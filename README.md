# O que é o Felix?

Felix é um web framework educativo escrito em Elixir e baseado no Phoenix.

Entre suas principais funcionalidades, estão:

* Servidor TCP com conexões concorrentes e um `supervisor`
* Parser e serializer (parciais) de requisições HTTP
* A ideia de *stages*, reproduzindo a ideia de `plugs`
* Um `router`, novamente inspirado no homônimo oferecido pela biblioteca `plug`
* `TOP.GenServer`, um GenServer simplificado para fins educacionais
* Uma aplicação de exemplo, `force_app`, demonstrando como usar o Felix

O Felix foi escrito para que sua complexidade fosse gradativamente 
aumentando, de modo que, caso queira estudá-lo, basta seguir os commits -- cada
mensagem contém uma lista dos tópicos necessários para implementar aquela mudança
no código.

# What is Felix?

Felix is an educational, Phoenix-inspired, web framework written in Elixir.

Here are some of its features:

* TCP server with concurrent connections and a `supervisor`
* Partial HTTP parser and serializer
* The concept of *stages*, very similar to `plugs`
* A `router`, again inspired by the `plug` library
* `TOP.GenServer`, a simplified GenServer for educational purposes
* `force_app`, an application that demonstrates how to use Felix

Felix was written with increasing complexity, such that the required Elixir 
knowledge needed to implement each part builds on the previous parts -- you will
find, in each commit messsage, the list of topics needed to implement that change.

