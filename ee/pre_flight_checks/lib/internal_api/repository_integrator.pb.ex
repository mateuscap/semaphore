defmodule InternalApi.RepositoryIntegrator.IntegrationType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t :: integer | :GITHUB_OAUTH_TOKEN | :GITHUB_APP | :BITBUCKET

  field :GITHUB_OAUTH_TOKEN, 0
  field :GITHUB_APP, 1
  field :BITBUCKET, 2
end

defmodule InternalApi.RepositoryIntegrator.IntegrationScope do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t :: integer | :FULL_CONNECTION | :ONLY_PUBLIC | :NO_CONNECTION

  field :FULL_CONNECTION, 0
  field :ONLY_PUBLIC, 1
  field :NO_CONNECTION, 2
end

defmodule InternalApi.RepositoryIntegrator.GetTokenRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          user_id: String.t(),
          repository_slug: String.t(),
          integration_type: InternalApi.RepositoryIntegrator.IntegrationType.t(),
          project_id: String.t()
        }

  defstruct user_id: "",
            repository_slug: "",
            integration_type: :GITHUB_OAUTH_TOKEN,
            project_id: ""

  field :user_id, 1, type: :string, json_name: "userId"
  field :repository_slug, 2, type: :string, json_name: "repositorySlug"

  field :integration_type, 3,
    type: InternalApi.RepositoryIntegrator.IntegrationType,
    json_name: "integrationType",
    enum: true

  field :project_id, 4, type: :string, json_name: "projectId"
end

defmodule InternalApi.RepositoryIntegrator.GetTokenResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          token: String.t(),
          expires_at: Google.Protobuf.Timestamp.t() | nil
        }

  defstruct token: "",
            expires_at: nil

  field :token, 1, type: :string
  field :expires_at, 2, type: Google.Protobuf.Timestamp, json_name: "expiresAt"
end

defmodule InternalApi.RepositoryIntegrator.CheckTokenRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          project_id: String.t()
        }

  defstruct project_id: ""

  field :project_id, 1, type: :string, json_name: "projectId"
end

defmodule InternalApi.RepositoryIntegrator.CheckTokenResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          valid: boolean,
          integration_scope: InternalApi.RepositoryIntegrator.IntegrationScope.t()
        }

  defstruct valid: false,
            integration_scope: :FULL_CONNECTION

  field :valid, 1, type: :bool

  field :integration_scope, 2,
    type: InternalApi.RepositoryIntegrator.IntegrationScope,
    json_name: "integrationScope",
    enum: true
end

defmodule InternalApi.RepositoryIntegrator.PreheatFileCacheRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          project_id: String.t(),
          path: String.t(),
          ref: String.t()
        }

  defstruct project_id: "",
            path: "",
            ref: ""

  field :project_id, 1, type: :string, json_name: "projectId"
  field :path, 2, type: :string
  field :ref, 3, type: :string
end

defmodule InternalApi.RepositoryIntegrator.GetFileRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          project_id: String.t(),
          path: String.t(),
          ref: String.t()
        }

  defstruct project_id: "",
            path: "",
            ref: ""

  field :project_id, 1, type: :string, json_name: "projectId"
  field :path, 2, type: :string
  field :ref, 3, type: :string
end

defmodule InternalApi.RepositoryIntegrator.GetFileResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          content: String.t()
        }

  defstruct content: ""

  field :content, 1, type: :string
end

defmodule InternalApi.RepositoryIntegrator.GithubInstallationInfoRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          project_id: String.t()
        }

  defstruct project_id: ""

  field :project_id, 1, type: :string, json_name: "projectId"
end

defmodule InternalApi.RepositoryIntegrator.GithubInstallationInfoResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          installation_id: integer,
          application_url: String.t(),
          installation_url: String.t()
        }

  defstruct installation_id: 0,
            application_url: "",
            installation_url: ""

  field :installation_id, 1, type: :int64, json_name: "installationId"
  field :application_url, 2, type: :string, json_name: "applicationUrl"
  field :installation_url, 3, type: :string, json_name: "installationUrl"
end

defmodule InternalApi.RepositoryIntegrator.GetRepositoriesRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          user_id: String.t(),
          integration_type: InternalApi.RepositoryIntegrator.IntegrationType.t()
        }

  defstruct user_id: "",
            integration_type: :GITHUB_OAUTH_TOKEN

  field :user_id, 1, type: :string, json_name: "userId"

  field :integration_type, 2,
    type: InternalApi.RepositoryIntegrator.IntegrationType,
    json_name: "integrationType",
    enum: true
end

defmodule InternalApi.RepositoryIntegrator.GetRepositoriesResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          repositories: [InternalApi.RepositoryIntegrator.Repository.t()]
        }

  defstruct repositories: []

  field :repositories, 1, repeated: true, type: InternalApi.RepositoryIntegrator.Repository
end

defmodule InternalApi.RepositoryIntegrator.Repository do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          addable: boolean,
          name: String.t(),
          full_name: String.t(),
          url: String.t(),
          description: String.t()
        }

  defstruct addable: false,
            name: "",
            full_name: "",
            url: "",
            description: ""

  field :addable, 1, type: :bool
  field :name, 2, type: :string
  field :full_name, 4, type: :string, json_name: "fullName"
  field :url, 3, type: :string
  field :description, 5, type: :string
end

defmodule InternalApi.RepositoryIntegrator.RepositoryIntegratorService.Service do
  @moduledoc false
  use GRPC.Service, name: "InternalApi.RepositoryIntegrator.RepositoryIntegratorService"

  rpc :GetToken,
      InternalApi.RepositoryIntegrator.GetTokenRequest,
      InternalApi.RepositoryIntegrator.GetTokenResponse

  rpc :CheckToken,
      InternalApi.RepositoryIntegrator.CheckTokenRequest,
      InternalApi.RepositoryIntegrator.CheckTokenResponse

  rpc :PreheatFileCache,
      InternalApi.RepositoryIntegrator.PreheatFileCacheRequest,
      Google.Protobuf.Empty

  rpc :GetFile,
      InternalApi.RepositoryIntegrator.GetFileRequest,
      InternalApi.RepositoryIntegrator.GetFileResponse

  rpc :GithubInstallationInfo,
      InternalApi.RepositoryIntegrator.GithubInstallationInfoRequest,
      InternalApi.RepositoryIntegrator.GithubInstallationInfoResponse

  rpc :GetRepositories,
      InternalApi.RepositoryIntegrator.GetRepositoriesRequest,
      InternalApi.RepositoryIntegrator.GetRepositoriesResponse
end

defmodule InternalApi.RepositoryIntegrator.RepositoryIntegratorService.Stub do
  @moduledoc false
  use GRPC.Stub, service: InternalApi.RepositoryIntegrator.RepositoryIntegratorService.Service
end
