module Api
  module V1
    class SurveysController < ApplicationController
      def create
        survey = Survey.new(title: params[:title], description: params[:description])

        if survey.save
          params[:questions]&.each do |question_params|
            survey.questions.create!(
              question_text: question_params[:question_text],
              question_type: question_params[:question_type],
              options: question_params[:options]
            )
          end

          render json: { survey: survey, questions: survey.questions }, status: :created
        else
          render json: { errors: survey.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end
end
