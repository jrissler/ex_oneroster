defmodule ExOneroster.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: ExOneroster.Repo

  def org_factory do
    %ExOneroster.Organizations.Org{
      dateLastModified: DateTime.utc_now,
      identifier: "IMS-HIGH-341",
      metadata: %{"ncesId" => "8892928234", "classification" => "private", "boarding" => "true", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      name: "IMS High",
      parent_id: nil,
      sourcedId: "9877728989-ABF-0001",
      status: "active",
      type: "national"
    }
  end

  def academic_session_factory do
    %ExOneroster.AcademicSessions.AcademicSession{
      sourcedId: "45454353453-ABF-0001",
      status: "active",
      dateLastModified: DateTime.utc_now,
      metadata: %{"ncesId" => "45454353453", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      title: "2019 School Year",
      startDate: "2019-06-14",
      endDate: "2018-08-10",
      type: "schoolYear",
      parent_id: nil,
      schoolYear: 2019
    }
  end
end
