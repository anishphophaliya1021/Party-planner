require 'test_helper'

class HostTest < ActiveSupport::TestCase

#check relationships
	should have_many(:guests)
	should have_many(:parties)
	should have_many(:locations)
	should have_many(:invitations).through(:parties)
	
#check validations
	should validate_presence_of(:first_name)
	should validate_presence_of(:last_name)
	should validate_presence_of(:email)
	should validate_uniqueness_of(:email)
	should validate_uniqueness_of(:username)
	should validate_presence_of(:username)
	should validate_presence_of(:password)
	
	should_not allow_value("3").for(:password)
	should_not allow_value("av").for(:password)
	should allow_value("sekdf").for(:password)
	should allow_value("sekd343f").for(:password)
	
  def new_host(attributes = {})
    attributes[:first_name] ||= 'foo'
    attributes[:last_name] ||= 'bar'
    attributes[:username] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    host = Host.new(attributes)
    host.valid? # run validations
    host
  end

  def setup
    Host.delete_all
  end

  def test_valid
    assert new_host.valid?
  end

  def test_require_username
    assert_equal ["can't be blank"], new_host(:username => '').errors[:username]
  end

  def test_require_password
    assert_equal ["can't be blank"], new_host(:password => '').errors[:password]
  end

  def test_require_well_formed_email
    assert_equal ["is invalid"], new_host(:email => 'foo@bar@example.com').errors[:email]
  end

  def test_validate_uniqueness_of_email
    new_host(:email => 'bar@example.com').save!
    assert_equal ["has already been taken"], new_host(:email => 'bar@example.com').errors[:email]
  end

  def test_validate_uniqueness_of_username
    new_host(:username => 'uniquename').save!
    assert_equal ["has already been taken"], new_host(:username => 'uniquename').errors[:username]
  end

  def test_validate_odd_characters_in_username
    assert_equal ["should only contain letters, numbers, or .-_@"], new_host(:username => 'odd ^&(@)').errors[:username]
  end

  def test_validate_password_length
    assert_equal ["is too short (minimum is 4 characters)"], new_host(:password => 'bad').errors[:password]
  end

  def test_require_matching_password_confirmation
    assert_equal ["doesn't match confirmation"], new_host(:password_confirmation => 'nonmatching').errors[:password]
  end

  def test_generate_password_hash_and_salt_on_create
    host = new_host
    host.save!
    assert host.password_hash
    assert host.password_salt
  end

  def test_authenticate_by_username
    Host.delete_all
    host = new_host(:username => 'foobar', :password => 'secret')
    host.save!
    assert_equal host, Host.authenticate('foobar', 'secret')
  end

  def test_authenticate_by_email
    Host.delete_all
    host = new_host(:email => 'foo@bar.com', :password => 'secret')
    host.save!
    assert_equal host, Host.authenticate('foo@bar.com', 'secret')
  end

  def test_authenticate_bad_username
    assert_nil Host.authenticate('nonexisting', 'secret')
  end

  def test_authenticate_bad_password
    Host.delete_all
    new_host(:username => 'foobar', :password => 'secret').save!
    assert_nil Host.authenticate('foobar', 'badpassword')
  end
end
