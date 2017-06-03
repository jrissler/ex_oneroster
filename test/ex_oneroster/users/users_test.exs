defmodule ExOneroster.UsersTest do
  use ExOneroster.DataCase

  alias ExOneroster.Users

  describe "users" do
    alias ExOneroster.Users.User

    test "list_users/0 returns all users" do
      user = insert(:user)
      assert Users.list_users() == [user |> Repo.preload([:identifiers, :agents, :orgs])]
    end

    test "get_user!/1 returns the user with given id" do
      user = insert(:user)
      assert Users.get_user!(user.id) == user |> Repo.preload([:identifiers, :agents, :orgs])
    end

    test "create_user/1 with valid data creates a user" do
      user_params = params_for(:user)

      assert {:ok, %User{} = user} = Users.create_user(user_params)
      assert user.agents == []
      assert user.dateLastModified == user_params.dateLastModified
      assert user.email == user_params.email
      assert user.enabledUser == user_params.enabledUser
      assert user.familyName == user_params.familyName
      assert user.givenName == user_params.givenName
      assert user.grades == user_params.grades
      assert user.metadata == user_params.metadata
      assert user.middleName == user_params.middleName
      assert user.password == user_params.password
      assert user.phone == user_params.phone
      assert user.role == user_params.role
      assert user.sms == user_params.sms
      assert user.sourcedId == user_params.sourcedId
      assert user.status == user_params.status
      assert user.username == user_params.username
      assert user.identifiers == []
      assert user.orgs == []
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(params_for(:user, sourcedId: nil))
    end

    test "update_user/2 with valid data updates the user" do
      existing_user = insert(:user) |> Repo.preload([:identifiers, :agents, :orgs])

      assert {:ok, user} = Users.update_user(existing_user, params_for(:user, sourcedId: "Bond..James Bond", dateLastModified: existing_user.dateLastModified))
      assert %User{} = user
      assert user.agents == []
      assert user.dateLastModified == existing_user.dateLastModified
      assert user.email == existing_user.email
      assert user.enabledUser == existing_user.enabledUser
      assert user.familyName == existing_user.familyName
      assert user.givenName == existing_user.givenName
      assert user.grades == existing_user.grades
      assert user.metadata == existing_user.metadata
      assert user.middleName == existing_user.middleName
      assert user.password == existing_user.password
      assert user.phone == existing_user.phone
      assert user.role == existing_user.role
      assert user.sms == existing_user.sms
      assert user.sourcedId == "Bond..James Bond"
      assert user.status == existing_user.status
      assert user.username == existing_user.username
      assert user.identifiers == []
      assert user.orgs == []
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = insert(:user) |> Repo.preload([:identifiers, :agents, :orgs])
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, params_for(:user, dateLastModified: "Not a date"))
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = insert(:user)
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = insert(:user)
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
