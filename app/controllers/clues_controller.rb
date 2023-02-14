class CluesController < ApplicationController
  def index
    # This service curently using dummy Endpoint
    Clue.create(file_content: QuestionService.fetch_data)
    reset_session
  end

  def quiz
    @conclusion = session[:conclusion] || nil
    @question = set_current_question
  end

  def question_response
    result = session[:result]
    current_question = set_current_question
    response = clue_params[:response].downcase
  
    context = current_question.dig("answers", response, "context")
    result << context
    next_question_id = current_question.dig("answers", response, "question_id")
  
    session[:result] = result
    session[:current_question_id] = next_question_id

    session[:conclusion] = determine_conclusion(result)
    redirect_to clues_quiz_path
  end

  private

  def reset_session
    session.clear
    session[:questions] = Clue.last.file_content["questions"]
    session[:conclusions] = Clue.last.file_content["conclusions"]
    session[:result] = []
    session[:current_question_id] = session[:questions].first["id"]
  end

  def set_current_question
    session[:questions].find {|question| question["id"] == session[:current_question_id]}
  end

  def determine_conclusion(result)
    conclusion =  session[:conclusions].find{|con| con["context"] == result}
    conclusion&.dig("conclusion")
  end

  def clue_params
    params.permit(:response)
  end

end
