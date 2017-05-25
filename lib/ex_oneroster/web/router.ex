defmodule ExOneroster.Web.Router do
  use ExOneroster.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ExOneroster.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/ims/oneroster/v1p1", ExOneroster.Web do
    pipe_through :api

    resources "/orgs", OrgController, except: [:new, :edit]
    resources "/academicSessions", AcademicSessionController, except: [:new, :edit]
    resources "/courses", CourseController, except: [:new, :edit]
    resources "/classes", ClassController, except: [:new, :edit]
  end
end
