time = Time.now
FactoryGirl.define do

  factory :article do
    sequence(:title) { |i| "Article#{i}" }
    sequence(:created_at) {|i| time + i * 1000}
    sequence(:topic) do |i|
      if [1, 2].include? i
        "sports"
      else
        "government"
      end
    end
    transient do
      assignments_count 1
    end

    after(:create) do |article, evaluator|
      create_list(:assignment, evaluator.assignments_count, article:article)

    end

  end

end
