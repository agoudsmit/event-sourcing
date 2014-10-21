Package.describe({
  summary: 'CQRS and Event Sourcing Infrastructure for Meteor.',
  name: 'space:cqrs',
  version: '1.0.0',
  git: 'https://github.com/CodeAdventure/space-cqrs.git',
});

Package.onUse(function(api) {

  api.versionsFrom("METEOR@0.9.4");

  api.use([
    'coffeescript',
    'space:base@1.1.0'
  ]);

  api.addFiles([

    'source/server.coffee',

    // DOMAIN
    'source/domain/domain_event.coffee',
    'source/domain/aggregate_root.coffee',

    // INFRASTRUCTURE
    'source/infrastructure/aggregate_repository.coffee',
    'source/infrastructure/events_collection.coffee',
    'source/infrastructure/event_bus.coffee',
    'source/infrastructure/event_store.coffee',

  ], 'server');

  api.addFiles([
    'source/client.coffee',
  ], 'client');

  api.addFiles([
    // INFRASTRUCTURE
    'source/infrastructure/command_bus.coffee'
  ]);

});

Package.onTest(function(api) {

  api.use([
    'coffeescript',
    'space:cqrs',
    'spacejamio:munit@2.0.2',
  ]);

  api.addFiles([

    // DOMAIN
    'tests/domain/aggregate_root.unit.coffee',
    'tests/domain/domain_event.unit.coffee',

    // INFRASTRUCTURE
    'tests/infrastructure/events_collection.unit.coffee',
    'tests/infrastructure/event_store.unit.coffee',

    // MODULE
    'tests/server_module.unit.coffee',
    'tests/server_module.integration.coffee',

  ], 'server');

});