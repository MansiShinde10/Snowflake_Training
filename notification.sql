CREATE OR REPLACE NOTIFICATION INTEGRATION snowpipe_event
  ENABLED = true
  TYPE = QUEUE
  NOTIFICATION_PROVIDER = AZURE_STORAGE_QUEUE
  AZURE_STORAGE_QUEUE_PRIMARY_URI = 'https://snowflakeaccount1903.queue.core.windows.net/snowpipequeue'
  AZURE_TENANT_ID = '8c7d1dfe-bbc5-4936-9f8b-e361c5dc3590';

  -- Register Integration
  DESC notification integration snowpipe_event;
