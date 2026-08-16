class Quote < ApplicationRecord
  CATEGORIES = %w[tech startup coding].freeze

  enum :category, CATEGORIES.index_with(&:itself), validate: true

  validates :text, :author, presence: true

  scope :for_category, ->(category) { where(category: category) }

  # Returns a random quote in +category+ whose id is not in +seen_ids+.
  def self.random_unseen(category, seen_ids)
    for_category(category).where.not(id: Array(seen_ids)).order(Arel.sql("RANDOM()")).first
  end

  def category_label
    category.to_s.capitalize
  end
end
