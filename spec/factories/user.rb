FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { [(0..1).to_a.sample(2),
                ('A'..'Z').to_a.sample(2),
                ('a'..'z').to_a.sample(2),
                "!#$%&'()*+,-./:;<=>?@[\]^_`{|}~".chars.sample(2),
                Faker::Internet.password
              ].flatten.shuffle.join('')
              }
  end
end
