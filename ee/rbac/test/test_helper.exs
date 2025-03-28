formatters = [ExUnit.CLIFormatter]

formatters =
  System.get_env("CI", "")
  |> case do
    "" ->
      formatters

    _ ->
      [JUnitFormatter | formatters]
  end

GrpcMock.defmock(RepositoryMock, for: InternalApi.Repository.RepositoryService.Service)
GrpcMock.defmock(ProjecthubMock, for: InternalApi.Projecthub.ProjectService.Service)
GrpcMock.defmock(OrganizationMock, for: InternalApi.Organization.OrganizationService.Service)

GRPC.Server.start([ProjecthubMock, RepositoryMock, OrganizationMock], 50_052)

ExUnit.configure(
  trace: true,
  capture_log: true,
  formatters: formatters
)

ExUnit.start()
