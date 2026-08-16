class QuotesController < ApplicationController
  include SeenQuotes

  def index
    load_page(params[:category].presence_in(Quote::CATEGORIES))
  end

  def create
    category = params[:category].presence_in(Quote::CATEGORIES)

    unless category
      redirect_to root_path, alert: "Choose a valid category."
      return
    end

    quote = next_unseen_quote(category)
    session[:current_quote_id] = quote&.id
    load_page(category)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path(category: category) }
    end
  end

  private

  def load_page(category)
    @categories = Quote::CATEGORIES
    @selected_category = category || Quote::CATEGORIES.first
    @quote = Quote.find_by(id: session[:current_quote_id])
    @seen_quotes = seen_quotes
    @progress = category_progress(@selected_category)
  end
end
