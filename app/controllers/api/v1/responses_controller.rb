module Api
  module V1
    class ResponsesController < ApplicationController
      def create
        response = Response.new(survey_id: params[:survey_id], user_identifier: params[:user_identifier])

        if response.save
          params[:answers]&.each do |answer_params|
            answer = response.answers.create!(
              question_id: answer_params[:question_id],
              answer_text: answer_params[:answer_text]
            )
            answer.file.attach(answer_params[:file]) if answer_params[:file].present?
          end

          render json: { response: response, answers: response.answers }, status: :created
        else
          render json: { errors: response.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        response = Response.find(params[:id])
        render json: { response: response, answers: response.answers }
      end

      def update
        response = Response.find(params[:id])

        if response.update(user_identifier: params[:user_identifier]) # Allow updating user identifier if needed
          response.answers.destroy_all # Remove old answers
          params[:answers]&.each do |answer_params|
            answer = response.answers.create!(
              question_id: answer_params[:question_id],
              answer_text: answer_params[:answer_text]
            )
            answer.file.attach(answer_params[:file]) if answer_params[:file].present?
          end

          render json: { response: response, answers: response.answers }
        else
          render json: { errors: response.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end
end
