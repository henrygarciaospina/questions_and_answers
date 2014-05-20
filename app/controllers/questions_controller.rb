class QuestionsController < ApplicationController

  def index
  end

  def new
    render text: "New question..."
  end

  def create
    render text: "Creating a question..."
  end

  def show
    render text: "The id is: #{params[:id]}"
  end

  def edit
    render text: "Editing question id: #{params[:id]}"
  end

end
