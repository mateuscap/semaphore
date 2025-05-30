# credo:disable-for-this-file Credo.Check.Design.DuplicatedCode
defmodule RepositoryHub.Server.Bitbucket.RegenerateWebhookActionTest do
  @moduledoc false
  alias RepositoryHub.BitbucketClient
  use RepositoryHub.ServerActionCase, async: false

  alias RepositoryHub.Adapters
  alias RepositoryHub.Server.RegenerateWebhookAction
  alias RepositoryHub.InternalApiFactory
  alias InternalApi

  alias RepositoryHub.{
    Model,
    BitbucketClientFactory,
    RepositoryModelFactory
  }

  alias InternalApi.Repository.RegenerateWebhookResponse
  import Mock

  setup_with_mocks(BitbucketClientFactory.mocks()) do
    %{adapter: Adapters.bitbucket()}
  end

  describe "Bitbucket RegenerateWebhookAction" do
    test "should create a webhook if it doesnt exist", %{adapter: adapter} do
      {:ok, repository} =
        RepositoryModelFactory.create_repository(
          name: "semaphoreci",
          owner: "repositoryhub"
        )

      request = InternalApiFactory.regenerate_webhook_request(repository_id: repository.id)

      assert {:ok, %RegenerateWebhookResponse{webhook: _webhook}} = RegenerateWebhookAction.execute(adapter, request)

      # Check if the webhook was created with a secret value
      assert_called(
        BitbucketClient.create_webhook(
          :meck.is(fn request_params ->
            {:ok, repository} = Model.RepositoryQuery.get_by_id(repository.id)

            decrypted_secret =
              RepositoryHub.Encryptor.decrypt!(
                RepositoryHub.WebhookSecretEncryptor,
                repository.hook_secret_enc,
                repository.id
              )

            assert decrypted_secret == request_params.secret
            true
          end),
          :_
        )
      )
    end

    test "should regenerate deploy key if it doesnt exist", %{adapter: adapter} do
      {:ok, repository} =
        RepositoryModelFactory.create_repository(
          name: "semaphoreci",
          owner: "repositoryhub"
        )

      request = InternalApiFactory.regenerate_webhook_request(repository_id: repository.id)

      assert {:ok, %RegenerateWebhookResponse{} = _response} = RegenerateWebhookAction.execute(adapter, request)

      assert {:ok, updated_repository} = Model.RepositoryQuery.get_by_id(repository.id)

      assert repository.hook_id != updated_repository.hook_id
    end

    test "should return error when there is an issue", %{adapter: adapter} do
      {:ok, repository} =
        RepositoryModelFactory.create_repository(
          name: "failed",
          owner: "repositoryhub"
        )

      request = InternalApiFactory.regenerate_webhook_request(repository_id: repository.id)

      assert {:error, error} = RegenerateWebhookAction.execute(adapter, request)

      assert error.status == GRPC.Status.failed_precondition()
      assert error.message == "Error"
    end
  end
end
