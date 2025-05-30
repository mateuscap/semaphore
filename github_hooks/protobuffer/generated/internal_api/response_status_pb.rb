# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: internal_api/response_status.proto

require 'google/protobuf'


descriptor_data = "\n\"internal_api/response_status.proto\x12\x0bInternalApi\"p\n\x0eResponseStatus\x12.\n\x04\x63ode\x18\x01 \x01(\x0e\x32 .InternalApi.ResponseStatus.Code\x12\x0f\n\x07message\x18\x02 \x01(\t\"\x1d\n\x04\x43ode\x12\x06\n\x02OK\x10\x00\x12\r\n\tBAD_PARAM\x10\x01\x42\x11Z\x0fresponse_statusb\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool

begin
  pool.add_serialized_file(descriptor_data)
rescue TypeError => e
  # Compatibility code: will be removed in the next major version.
  require 'google/protobuf/descriptor_pb'
  parsed = Google::Protobuf::FileDescriptorProto.decode(descriptor_data)
  parsed.clear_dependency
  serialized = parsed.class.encode(parsed)
  file = pool.add_serialized_file(serialized)
  warn "Warning: Protobuf detected an import path issue while loading generated file #{__FILE__}"
  imports = [
  ]
  imports.each do |type_name, expected_filename|
    import_file = pool.lookup(type_name).file_descriptor
    if import_file.name != expected_filename
      warn "- #{file.name} imports #{expected_filename}, but that import was loaded as #{import_file.name}"
    end
  end
  warn "Each proto file must use a consistent fully-qualified name."
  warn "This will become an error in the next major version."
end

module InternalApi
  ResponseStatus = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("InternalApi.ResponseStatus").msgclass
  ResponseStatus::Code = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("InternalApi.ResponseStatus.Code").enummodule
end
