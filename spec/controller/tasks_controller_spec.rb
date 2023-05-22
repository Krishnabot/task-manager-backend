require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'returns all tasks' do
      task1 = FactoryBot.create(:task1)
      task2 = FactoryBot.create(:task2)

      get :index
      json_response = JSON.parse(response.body)

      expect(json_response.length).to eq(2)
      expect(json_response.first['title']).to eq(task1.title)
      expect(json_response.second['title']).to eq(task2.title)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      task1 = FactoryBot.create(:task1)
      get :show, params: { id: task1.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'creates a new task' do
      task_params = { task: { title: 'New Task', completed: false } }

      expect do
        post :create, params: task_params
      end.to change(Task, :count).by(1)

      expect(response).to have_http_status(:created)
      json_response = JSON.parse(response.body)
      expect(json_response['title']).to eq('New Task')
    end

    it 'returns unprocessable entity for invalid task' do
      task_params = { task: { title: '', completed: false } }

      post :create, params: task_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH/PUT #update' do
    it 'updates the task' do
      task1 = FactoryBot.create(:task1)
      updated_title = 'Updated Task'
      task_params = { task: { title: updated_title } }

      patch :update, params: { id: task1.id }.merge(task_params)

      expect(response).to have_http_status(:ok)
      task1.reload
      expect(task1.title).to eq(updated_title)
    end

    it 'returns unprocessable entity for invalid task' do
      task2 = FactoryBot.create(:task2)
      task_params = { task: { title: '' } }

      patch :update, params: { id: task2.id }.merge(task_params)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the task' do
      task1 = FactoryBot.create(:task1)

      expect do
        delete :destroy, params: { id: task1.id }
      end.to change(Task, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
