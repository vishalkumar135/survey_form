module Api
  module V1
    class UsersController < ApplicationController
      def responses
        responses = Response.where(user_identifier: params[:user_identifier])
        render json: responses.as_json(include: { answers: { include: { file_attachment: { only: [:filename, :url] } } } })
      end
    end
  end
end
