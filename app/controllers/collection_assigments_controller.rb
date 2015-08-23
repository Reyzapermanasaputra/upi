class CollectionAssigmentsController < ApplicationController
  load_and_authorize_resource except: :create
  def index
    assigment = Assigment.find(params[:assigment_id])
    @collection = assigment.collection_assigments
  end

  def new
    assigment = Assigment.find(params[:assigment_id])
    @collection = assigment.collection_assigments.build
  end

  def create
    assigment = Assigment.find(params[:assigment_id])
    @collection = assigment.collection_assigments.new(params_collection)
    @collection.user_id = current_user.id

    if @collection.save
      redirect_to (:back), notice: 'Upload Success'
    else
      flash[:alert] = 'Upload Failed'
      redirect_to (:back)
    end
  end

  def destroy
    assigment = Assigment.find(params[:assigment_id])
    @collection = assigment.collection_assigments.find(params[:id])
    @collection.destroy
    redirect_to (:back), notice: "Successfully Destroyed"
  end

  private

  def params_collection
    params.require(:collection_assigment).permit(:attachment, :user_id, :assigment_id)
  end

end
