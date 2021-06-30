FactoryBot.define do
  factory :todo do
    title { "todo title" }
    url { "http://example.com" }
    completed { true }
    order { 1 }
  end
end