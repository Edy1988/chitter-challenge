require 'user'

describe 'Sign Up' do

  it 'creates a user with given details' do
    user = User.sign_up('a name', 'an email', 'a username', 'a password')

    expect(user.id).to be > 0
    expect(user.name).to eq 'a name'
    expect(user.email).to eq 'an email'
    expect(user.username).to eq 'a username'
  end

  it 'persits a user with given details' do
    User.sign_up('a name', 'an email', 'a username', 'a password')

    result = PG.connect(dbname: 'chitter_test').exec('SELECT * FROM users')

    expect(result.count).to eq 1
    expect(result[0]["name"]).to eq 'a name'
    expect(result[0]["email"]).to eq 'an email'
    expect(result[0]["username"]).to eq 'a username'
    expect(result[0]["password"]).to eq 'a password'
  end

end
