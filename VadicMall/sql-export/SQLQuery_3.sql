-- Update SuperAdmin password hash
UPDATE [dbo].[Users] 
SET [PasswordHash] = '$2a$11$K6qXhXF9ZkO7nY.5kMxXO.8XyZ5aQ1bC2dE3fG4hI5jK6lM7nO8pQ9rS' 
WHERE [Email] = 'admin@vedicastro.com';

-- Update Astrologer password hash
UPDATE [dbo].[Users] 
SET [PasswordHash] = '$2a$11$L7qXhXF9ZkO7nY.5kMxXO.8XyZ5aQ1bC2dE3fG4hI5jK6lM7nO8pQ9rT' 
WHERE [Email] = 'astrologer@vedicastro.com';

-- Update Customer password hash
UPDATE [dbo].[Users] 
SET [PasswordHash] = '$2a$11$M8rXhXF9ZkO7nY.5kMxXO.8XyZ5aQ1bC2dE3fG4hI5jK6lM7nO8pQ9rU' 
WHERE [Email] = 'customer@vedicastro.com';

-- Verify
SELECT [Email], [PasswordHash] FROM [dbo].[Users];
select * from Products