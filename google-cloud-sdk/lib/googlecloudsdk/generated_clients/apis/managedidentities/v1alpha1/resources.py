# -*- coding: utf-8 -*- #
# Copyright 2023 Google LLC. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""Resource definitions for Cloud Platform Apis generated from apitools."""

import enum


BASE_URL = 'https://managedidentities.googleapis.com/v1alpha1/'
DOCS_URL = 'https://cloud.google.com/managed-microsoft-ad/'


class Collections(enum.Enum):
  """Collections for all supported apis."""

  PROJECTS = (
      'projects',
      'projects/{projectsId}',
      {},
      ['projectsId'],
      True
  )
  PROJECTS_LOCATIONS = (
      'projects.locations',
      '{+name}',
      {
          '':
              'projects/{projectsId}/locations/{locationsId}',
      },
      ['name'],
      True
  )
  PROJECTS_LOCATIONS_GLOBAL_DOMAINS = (
      'projects.locations.global.domains',
      '{+name}',
      {
          '':
              'projects/{projectsId}/locations/global/domains/{domainsId}',
      },
      ['name'],
      True
  )
  PROJECTS_LOCATIONS_GLOBAL_DOMAINS_BACKUPS = (
      'projects.locations.global.domains.backups',
      '{+name}',
      {
          '':
              'projects/{projectsId}/locations/global/domains/{domainsId}/'
              'backups/{backupsId}',
      },
      ['name'],
      True
  )
  PROJECTS_LOCATIONS_GLOBAL_DOMAINS_SCHEMAEXTENSIONS = (
      'projects.locations.global.domains.schemaExtensions',
      '{+name}',
      {
          '':
              'projects/{projectsId}/locations/global/domains/{domainsId}/'
              'schemaExtensions/{schemaExtensionsId}',
      },
      ['name'],
      True
  )
  PROJECTS_LOCATIONS_GLOBAL_DOMAINS_SQLINTEGRATIONS = (
      'projects.locations.global.domains.sqlIntegrations',
      '{+name}',
      {
          '':
              'projects/{projectsId}/locations/global/domains/{domainsId}/'
              'sqlIntegrations/{sqlIntegrationsId}',
      },
      ['name'],
      True
  )
  PROJECTS_LOCATIONS_GLOBAL_OPERATIONS = (
      'projects.locations.global.operations',
      '{+name}',
      {
          '':
              'projects/{projectsId}/locations/global/operations/'
              '{operationsId}',
      },
      ['name'],
      True
  )
  PROJECTS_LOCATIONS_GLOBAL_PEERINGS = (
      'projects.locations.global.peerings',
      '{+name}',
      {
          '':
              'projects/{projectsId}/locations/global/peerings/{peeringsId}',
      },
      ['name'],
      True
  )

  def __init__(self, collection_name, path, flat_paths, params,
               enable_uri_parsing):
    self.collection_name = collection_name
    self.path = path
    self.flat_paths = flat_paths
    self.params = params
    self.enable_uri_parsing = enable_uri_parsing
