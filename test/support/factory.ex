defmodule ExOneroster.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: ExOneroster.Repo

  def org_factory do
    %ExOneroster.Orginizations.Org{
      child: "9877728989-ABF-CHILD-0001",
      dateLastModified: DateTime.utc_now,
      identifier: "IMS-HIGH-341",
      metadata: %{"ncesId" => "8892928234", "classification" => "private", "boarding" => "true", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      name: "IMS High",
      parent: "9877728989-ABF-PARENT-0001",
      sourceId: "9877728989-ABF-0001",
      status: "active",
      type: "national"
    }
  end
end
