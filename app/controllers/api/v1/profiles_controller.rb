# app/controllers/api/v1/profiles_controller.rb
module Api
  module V1
    class ProfilesController < ApiController
      before_action :set_profile, only: %i[show update]

      def index
        @profiles = Profile.by_team(current_user)
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @profiles,
          serializer: ProfileSerializer
        ).to_json
      end

      def create
        @profile = current_user.build_profile(profile_params)

        if @profile.save
          render json: @profile
        else
          render json: @profile.errors, status: :bad_request
        end
      end

      def show
        render json: @profile
      end

      def update
        if @profile.update(profile_params)
          render json: @profile
        else
          render json: @profile.errors, status: :bad_request
        end
      end

      private

      def set_profile
        @profile = Profile.find(params[:id])
      end

      def profile_params
        params.require(:profile).permit(:birthday, :day_of_joinning, :height, :gender, :blood_type, :prefecture_id)
      end
    end
  end
end
