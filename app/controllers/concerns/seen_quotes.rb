module SeenQuotes
  extend ActiveSupport::Concern

  SEEN_KEY = :seen_quote_ids
  HISTORY_KEY = :quote_history_ids

  private

  def seen_quote_ids
    Array(session[SEEN_KEY]).map(&:to_i)
  end

  def quote_history_ids
    Array(session[HISTORY_KEY]).map(&:to_i)
  end

  def seen_quotes
    ids = quote_history_ids
    return Quote.none if ids.empty?

    quotes_by_id = Quote.where(id: ids).index_by(&:id)
    ids.reverse.filter_map { |id| quotes_by_id[id] }
  end

  def next_unseen_quote(category)
    category_ids = Quote.for_category(category).pluck(:id)
    return nil if category_ids.empty?

    seen = seen_quote_ids
    unseen_in_category = category_ids - seen

    # Fresh cycle once every quote in this category has been shown
    if unseen_in_category.empty?
      seen -= category_ids
      session[SEEN_KEY] = seen
    end

    quote = Quote.random_unseen(category, seen)
    return nil unless quote

    session[SEEN_KEY] = seen + [quote.id]
    session[HISTORY_KEY] = quote_history_ids + [quote.id]
    quote
  end

  # How far the visitor has worked through a category in the current cycle.
  def category_progress(category)
    total = Quote.for_category(category).count
    seen = (Quote.for_category(category).pluck(:id) & seen_quote_ids).size

    { seen: seen, total: total, percent: total.zero? ? 0 : (seen * 100.0 / total).round }
  end

  def clear_quote_history!
    session.delete(SEEN_KEY)
    session.delete(HISTORY_KEY)
  end
end
