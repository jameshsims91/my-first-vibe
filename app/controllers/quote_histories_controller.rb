class QuoteHistoriesController < ApplicationController
  include SeenQuotes

  def destroy
    category = session[:current_quote_id] && Quote.find_by(id: session[:current_quote_id])&.category

    clear_quote_history!
    session.delete(:current_quote_id)

    @categories = Quote::CATEGORIES
    @selected_category = category.presence_in(Quote::CATEGORIES) || Quote::CATEGORIES.first
    @quote = nil
    @seen_quotes = seen_quotes
    @progress = category_progress(@selected_category)

    respond_to do |format|
      format.turbo_stream { render "quotes/create" }
      format.html { redirect_to root_path, notice: "Seen history cleared." }
    end
  end
end
