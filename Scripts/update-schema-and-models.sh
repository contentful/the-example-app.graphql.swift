#!/bin/bash


apollo schema:download --header "Authorization: Bearer b2b980b80e4154cb8cdd1d3b156d7b5d17f5eeb3ba3b1035db39cc842b199866" \
--endpoint https://graphql.contentful.com/content/v1/spaces/qz0n5cdakyl9/environments/master

apollo codegen:generate --target=swift --schema=schema.json --queries=TheExampleAppQueries.graphql the-example-app.swift/API.swift
