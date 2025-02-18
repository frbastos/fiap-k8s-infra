# resource "aws_apigatewayv2_api" "api_gateway" {
#   name          = "${local.env}-http-api-gateway"
#   protocol_type = "HTTP"
# }

# # Microserviço 1 - Pedido
# resource "aws_apigatewayv2_integration" "pedido_integration" {
#   api_id                 = aws_apigatewayv2_api.api_gateway.id
#   integration_type       = "HTTP_PROXY"
#   integration_method     = "ANY"
#   integration_uri        = "http://ae651ec3cad324504aa3ff274a98a32e-186632489.us-east-1.elb.amazonaws.com/pedidos"
# }

# # Microserviço 2 - Pagamento
# resource "aws_apigatewayv2_integration" "pagamento_integration" {
#   api_id                 = aws_apigatewayv2_api.api_gateway.id
#   integration_type       = "HTTP_PROXY"
#   integration_method     = "ANY"
#   integration_uri        = "http://a0461a39a349547f19681e5d45d7f809-1320229298.us-east-1.elb.amazonaws.com/pagamento"
# }

# # Microserviço 2 - Producao
# resource "aws_apigatewayv2_integration" "producao_integration" {
#   api_id                 = aws_apigatewayv2_api.api_gateway.id
#   integration_type       = "HTTP_PROXY"
#   integration_method     = "ANY"
#   integration_uri        = "http://a0b2ba96ac7db49869ebfabbccd10a31-932981715.us-east-1.elb.amazonaws.com/cozinha"
# }

# # Rota para Microserviço - Pedido
# resource "aws_apigatewayv2_route" "pedido_route" {
#   api_id    = aws_apigatewayv2_api.api_gateway.id
#   route_key = "ANY /pedidos/{proxy+}"
#   target    = "integrations/${aws_apigatewayv2_integration.pedido_integration.id}"
# }

# resource "aws_apigatewayv2_route" "produto_route" {
#   api_id    = aws_apigatewayv2_api.api_gateway.id
#   route_key = "ANY /produtos/{proxy+}"
#   target    = "integrations/${aws_apigatewayv2_integration.pedido_integration.id}"
# }

# # Rota para Microserviço - Pagamento
# resource "aws_apigatewayv2_route" "pagamento_route" {
#   api_id    = aws_apigatewayv2_api.api_gateway.id
#   route_key = "ANY /pagamento/{proxy+}"
#   target    = "integrations/${aws_apigatewayv2_integration.pagamento_integration.id}"
# }

# # Rota para Microserviço - Cozinha
# resource "aws_apigatewayv2_route" "cozinha_route" {
#   api_id    = aws_apigatewayv2_api.api_gateway.id
#   route_key = "ANY /cozinha"
#   target    = "integrations/${aws_apigatewayv2_integration.producao_integration.id}"
# }

# # Stage
# resource "aws_apigatewayv2_stage" "api_gateway_stage" {
#   api_id      = aws_apigatewayv2_api.api_gateway.id
#   name        = "prod"
#   auto_deploy = true
# }