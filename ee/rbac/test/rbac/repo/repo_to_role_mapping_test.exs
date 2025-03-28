defmodule Rbac.Repo.RepoToRoleMapping.Test do
  use Rbac.RepoCase, async: true

  alias Rbac.Repo.RepoToRoleMapping

  @org_id "7ae898b3-c511-4968-9641-fc8acda34853"
  @non_existant_org_id "4ae898b3-c511-4968-9641-fc8acda34859"

  setup do
    {:ok, mapping_for_specific_org} = Support.Factories.RepoToRoleMapping.insert(org_id: @org_id)

    state = %{
      :mapping_for_specific_org => mapping_for_specific_org
    }

    {:ok, state}
  end

  describe "get_repo_to_role_mapping/1" do
    test "with org_id that does not have its own mapper" do
      mapper = RepoToRoleMapping.get_repo_to_role_mapping(@non_existant_org_id)
      assert mapper === nil
    end

    test "with org_id that has its own mapper", state do
      mapper = RepoToRoleMapping.get_repo_to_role_mapping(@org_id)
      assert state[:mapping_for_specific_org] === mapper
    end
  end
end
