FactoryBot.define do
  factory :task1, class: Task do
    id { 1 }
    title { 'Sample Task' }
    completed { false }
  end

  factory :task2, class: Task do
    id { 2 }
    title { 'Another Sample Task' }
    completed { false }
  end
end
