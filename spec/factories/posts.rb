FactoryBot.define do
  factory :post do
    title { 'Title' }
    body { 'Bla-bla' }
    published_at { Time.now }

    association :user, factory: :user
  end
end
