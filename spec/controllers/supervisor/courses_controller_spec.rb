require "rails_helper"
require "shoulda-matchers"
require 'support/factory_bot'
include SessionsHelper

RSpec.describe Supervisor::CoursesController, type: :controller do
  let(:course){FactoryBot.create :course}
  let(:trainee){FactoryBot.create :trainee}
  let(:supervisor){FactoryBot.create :user}
  let!(:invalid_params){{name: "sdf"}}
  let!(:user_course){FactoryBot.create :user_course,course_id: course.id,user_id: trainee.id}
  let!(:subject){FactoryBot.create :subject,course_id: course.id}
  let!(:course_subject){FactoryBot.create :course_subject,course_id: course.id,subject_id: subject.id}
  let!(:user_subject){FactoryBot.create :user_subject,course_subject_id: course_subject.id,user_id: trainee.id}
  let!(:task){FactoryBot.create :task,subject_id: subject.id}
  let!(:user_task){FactoryBot.create :user_task,user_subject_id: user_subject.id,task_id: task.id}
  let!(:course_start){FactoryBot.create :course, status: 1}
  let!(:course_finsh){FactoryBot.create :course, status: 2}

  before do
    log_in FactoryBot.create :user
    current_user
  end
  describe "before action" do
    before{log_in supervisor}
  end

  describe "GET #show" do
    context "when valid param" do
      it "should render show template" do
        get :show, params: {id: course.id, user_id: current_user.id}
        expect(response).to render_template :show
      end
    end

    context "when invalid param" do
      it "show flash" do
        get :show, params: {id: -2}
        expect(flash[:warning]).to eq(I18n.t "courses.subjects.course_subject_not_found")
      end
    end
  end

  describe "GET #assign_trainee" do
    let(:course){FactoryBot.create :course}
    context "Supervisor assign trainee" do
        it do
          get :assign_trainee, params: {id: course.id}, xhr: true
          expect(response.content_type).to eq("text/javascript; charset=utf-8")
        end
    end
  end

  describe "POST create" do
    before {log_in supervisor}

    context "when valid attributes" do
      it do
        post :create, params: {course: FactoryBot.attributes_for(:course)}
        expect(assigns(:course)).to be_a Course
      end
    end

    context "when invalid attributes" do
      it do
        post :create, params: {course: invalid_params}
        expect(response).to render_template :new
      end
    end
  end

  describe "GET index" do
    context "when user signed in but not an supervisor" do
      let(:not_supervisor){FactoryBot.create :not_supervisor}
      before do
        log_in not_supervisor
        get :index
      end

      it{expect(flash[:success]).to eq(
        I18n.t "session.new.not_access")}
    end

    context "when user signed in as an supervisor" do
      before do
        log_in supervisor
        get :index
      end

      it{expect(response).to render_template :index}
    end
  end

  describe "GET new" do
    before{get :new}
    context "when user signed in as an supervisor" do
      before do
        log_in supervisor
        get :new
      end
      it{expect(response).to render_template :new}
    end
  end

  describe "GET edit" do
    context "when user not signed in" do
      before{get :edit, params:{id: course.id}}
    end

    context "when user signed in as an supervisor" do
      before do
        log_in supervisor
        get :edit, params:{id: course.id}
      end
      it{expect(response).to render_template :edit}
    end
  end

  describe "PATCH #update" do
    it "update with name" do
      patch :update, params: {id: course.id, course: {name: "Ruby on Rails"}}
      expect(flash[:success]).to match(I18n.t("courses.supervisor.update.success"))
      expect(response).to redirect_to(supervisor_courses_path)
    end

    it "update with invalid name" do
      patch :update, params: {id: course.id, course: {name: ""}}
      expect(flash[:danger]).to match(I18n.t("courses.supervisor.update.fail"))
      expect(response).to render_template :edit
    end
  end
   
  describe "#add_trainee" do
    it "add trainee with course start or open" do
      post :add_trainee, params: {id: course.id, trainee_ids: [trainee.id]}
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "add trainee with course finish" do
      post :add_trainee, params: {id: course_finsh.id, trainee_ids: trainee.id}
      expect(flash[:warning]).to eq(I18n.t "courses.supervisor.load_course.check_open?")
    end
  end

  describe "#delete_trainee" do
    it "delete trainee on course" do
      delete :delete_trainee, params: {id: course.id, user_id: trainee.id}
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "delete trainee not exit on course" do
      delete :delete_trainee, params: {id: course.id}
      expect(flash[:warning]).to eq(I18n.t "courses.supervisor.load_course.trainee_course?")
    end
  end

  describe "#start" do
    it "start with curse open" do
      post :start, params: {id: course.id, user_id: [trainee.id]}
      expect(flash[:success]).to match(I18n.t("courses.supervisor.start_success"))
      expect(response).to redirect_to supervisor_courses_path
    end

    it "start with curse finished" do
      post :start,  params: {id: course_finsh.id, user_id: [trainee.id]}
      expect(flash[:warning]).to match(I18n.t("courses.supervisor.start_course_not_allow"))
      expect(response).to redirect_to supervisor_courses_path
    end
  end

  describe "#finish" do
    it "finish with course start" do
      post :finish, params: {id: course_start.id, user_id: [trainee.id]}
      expect(flash[:success]).to match(I18n.t("courses.supervisor.finish_course_sussccess"))
      expect(response).to redirect_to supervisor_courses_path
    end

    it "finish with course finish" do
      post :finish, params: {id: course_finsh.id, user_id: [trainee.id]}
      expect(flash[:warning]).to match(I18n.t("courses.supervisor.finish_course_not_allow"))
      expect(response).to redirect_to supervisor_courses_path
    end
  end
end
