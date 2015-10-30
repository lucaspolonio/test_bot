require 'sinatra'
require 'json'
require 'byebug'

post '/payload' do
    push = JSON.parse(request.body.read)
    pr_body = push['pull_request']['body']
    puts process_pr_body(pr_body)
end

# ```
# Bot, please compare:
# /meta/leagues - 1.7.3, 1.7.4
# /another/endpoint - 1.7.3
# /another/endpoint - all_major_versions
# ```
def process_pr_body(body)
  byebug
  instructions_json = /```compare_endpoints\n(.*)\n```/m.match(body)
  return '' unless instructions_json

  instructions = instructions_json[0]
  instructions = JSON.parse(instructions_json)
  instructions.each do |endpoint, versions|
    puts endpoint
    versions.each do |version|
      puts version
    end
  end
end
