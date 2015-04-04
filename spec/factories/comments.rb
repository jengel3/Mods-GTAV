FactoryGirl.define do
  factory :comment do
    text "MyText"
like_count 1
user_id 1
submission_id 1
  end

end
