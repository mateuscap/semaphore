# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: cache.proto

require 'google/protobuf'

require_relative 'internal_api/response_status_pb'


descriptor_data = "\n\x0b\x63\x61\x63he.proto\x12\x11InternalApi.Cache\x1a\"internal_api/response_status.proto\"\x0f\n\rCreateRequest\"O\n\x0e\x43reateResponse\x12\x10\n\x08\x63\x61\x63he_id\x18\x01 \x01(\t\x12+\n\x06status\x18\x02 \x01(\x0b\x32\x1b.InternalApi.ResponseStatus\"#\n\x0f\x44\x65scribeRequest\x12\x10\n\x08\x63\x61\x63he_id\x18\x01 \x01(\t\"h\n\x10\x44\x65scribeResponse\x12\'\n\x05\x63\x61\x63he\x18\x01 \x01(\x0b\x32\x18.InternalApi.Cache.Cache\x12+\n\x06status\x18\x02 \x01(\x0b\x32\x1b.InternalApi.ResponseStatus\"\"\n\x0e\x44\x65stroyRequest\x12\x10\n\x08\x63\x61\x63he_id\x18\x01 \x01(\t\">\n\x0f\x44\x65stroyResponse\x12+\n\x06status\x18\x02 \x01(\x0b\x32\x1b.InternalApi.ResponseStatus\"8\n\rUpdateRequest\x12\'\n\x05\x63\x61\x63he\x18\x01 \x01(\x0b\x32\x18.InternalApi.Cache.Cache\"f\n\x0eUpdateResponse\x12\'\n\x05\x63\x61\x63he\x18\x01 \x01(\x0b\x32\x18.InternalApi.Cache.Cache\x12+\n\x06status\x18\x02 \x01(\x0b\x32\x1b.InternalApi.ResponseStatus\"4\n\x05\x43\x61\x63he\x12\n\n\x02id\x18\x01 \x01(\t\x12\x12\n\ncredential\x18\x02 \x01(\t\x12\x0b\n\x03url\x18\x03 \x01(\t2\xd3\x02\n\x0c\x43\x61\x63heService\x12M\n\x06\x43reate\x12 .InternalApi.Cache.CreateRequest\x1a!.InternalApi.Cache.CreateResponse\x12S\n\x08\x44\x65scribe\x12\".InternalApi.Cache.DescribeRequest\x1a#.InternalApi.Cache.DescribeResponse\x12P\n\x07\x44\x65stroy\x12!.InternalApi.Cache.DestroyRequest\x1a\".InternalApi.Cache.DestroyResponse\x12M\n\x06Update\x12 .InternalApi.Cache.UpdateRequest\x1a!.InternalApi.Cache.UpdateResponseb\x06proto3"

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
    ["InternalApi.ResponseStatus", "internal_api/response_status.proto"],
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
  module Cache
    CreateRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("InternalApi.Cache.CreateRequest").msgclass
    CreateResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("InternalApi.Cache.CreateResponse").msgclass
    DescribeRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("InternalApi.Cache.DescribeRequest").msgclass
    DescribeResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("InternalApi.Cache.DescribeResponse").msgclass
    DestroyRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("InternalApi.Cache.DestroyRequest").msgclass
    DestroyResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("InternalApi.Cache.DestroyResponse").msgclass
    UpdateRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("InternalApi.Cache.UpdateRequest").msgclass
    UpdateResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("InternalApi.Cache.UpdateResponse").msgclass
    Cache = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("InternalApi.Cache.Cache").msgclass
  end
end
