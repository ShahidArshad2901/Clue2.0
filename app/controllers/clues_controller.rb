class CluesController < ApplicationController
  before_action :set_current_question, only: %i[quiz question_response]
  def index
    # This service curently using dummy Endpoint
    Clue.create(file_content: QuestionService.fetch_data)
    reset_session
  end

  def quiz
    @conclusion = session[:conclusion] || nil
    @question = @current_question
  end

  def question_response
    response = clue_params[:response].downcase
  
    session[:result] << @current_question.dig("answers", response, "context")
    session[:current_question_id] = @current_question.dig("answers", response, "question_id")

    session[:conclusion] = determine_conclusion
    redirect_to clues_quiz_path
  end

  private

  def reset_session
    session.clear
    clue = Clue.last.file_content
    session[:questions] = clue["questions"]
    session[:conclusions] = clue["conclusions"]
    session[:result] = []
    session[:current_question_id] = session[:questions].first["id"]
  end

  def set_current_question
    @current_question = session[:questions].find {|question| question["id"] == session[:current_question_id]}
  end

  def determine_conclusion
    conclusion = session[:conclusions].find{|con| con["context"] == session['result']}
    conclusion&.dig("conclusion")
  end

  def clue_params
    params.permit(:response)
  end

end
