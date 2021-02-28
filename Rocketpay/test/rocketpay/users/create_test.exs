defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.Repo
  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, return an user" do
      params = %{
        name: "Daniel",
        password: "123456",
        nickname: "dan",
        email: "dan@email.com",
        age: 20
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Daniel", age: 20, id: ^user_id} = user
    end

    test "when there are invalid params, return an error" do
      params = %{
        name: "Daniel",
        nickname: "dan",
        email: "dan@email.com",
        age: 13
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
