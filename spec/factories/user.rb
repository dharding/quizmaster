Factory.define :user do |u|
  u.first_name {|o| Faker::Name.first_name}
  u.last_name {|o| Faker::Name.last_name}
  u.sequence(:email) {|i| "#{Faker::Internet.user_name}#{i}@#{Faker::Internet.domain_name}"}
  u.email_confirmation {|j| j.email}
  u.password_salt {|j| Authlogic::Random.hex_token}
  u.password "secret"
  u.password_confirmation {|j| j.password}
  u.crypted_password {|j| Authlogic::CryptoProviders::Sha512.encrypt(j.password + j.password_salt)}
  u.persistence_token {|j| Authlogic::Random.hex_token}
  u.single_access_token {|j| Authlogic::Random.friendly_token}
  u.perishable_token {|j| Authlogic::Random.friendly_token}
  u.active true
end

Factory.define :inactive_user, :parent => :user do |u|
  u.active false
end

Factory.define :admin, :parent => :user do |u|
  u.admin true
end
