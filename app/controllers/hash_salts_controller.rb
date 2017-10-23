class HashSaltsController < ApplicationController
  # HashSalt REST API must be protected by reverse proxy
  protect_from_forgery except: [:show, :create]

  def show
    @salt = HashSalt.order('created_at DESC').first
    respond_to do |format|
      format.json { render json: @salt }
    end
  end

  def create
    @salt = HashSalt.new(salt: params[:salt])
    respond_to do |format|
      if @salt.save
        format.json { render json: { result: "ok", salt: @salt } }
      else
        format.json { render json: { result: "error", message: @salt.errors } }
      end
    end
  end
end
