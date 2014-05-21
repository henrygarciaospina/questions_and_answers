class QuestionsController < ApplicationController
  before_action :find_question, only: [:show, :edit, :destroy, :update, :vote_up, :vote_down]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_attributes)
    if @question.save
      redirect_to questions_path, notice: "Your question was created successfully"
    else
      flash.now[:error] = "Please correct the form"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @question.update_attributes(question_attributes)
      redirect_to @question, notice: "Question updated successfully"
    else
      flash.now[:error] = "Couldn't update"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      redirect_to questions_path, notice: "Question deleted successfully"
    else
      redirect_to question_path, error: "Delete question failed"
    end
  end

  def vote_up
    @question.increment!(:vote_count)
    session[:has_voted] = true
    redirect_to @question
  end

  def vote_down
  end

  private

  def question_attributes
    params.require(:question).permit([:title, :description, :vote_up, :vote_down])
  end

  def find_question
    @question = Question.find params[:id]
  end

end
