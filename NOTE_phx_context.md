# Contexts

It is about system design in software development.

Quote from https://hexdocs.pm/phoenix/contexts.html:
> Contexts are dedicated modules what expose and group related functionality. By giving modules that expose and group related functionality the name **contexts**, we help developers indentify these patterns and talk about them. At the end of the day, contexts are just modules, as are your _controllers_, _views_, etc.

> In Phoenix, contexts often encapsulate data access and data validation. They often talk to a database or APIs. Overall, think of them as boundaries to _decouple_ and _isolate_ our systems into manageable, independent parts.

## Combine contexts and layers designing

Ref: https://stackoverflow.com/questions/61821286/phoenix-elixir-tips-when-to-create-a-new-context

  - Contexts group your modules by _what_ they do.
  - Layers group them by _how_ they do it.

## Contexts in Phoenix by generators:

### Starting with Generators
  * `mix phx.gen.html Catalog Product products title:string description:string price:decimal views:integer`
  * `mix phx.gen.html Context Schema  table-s  field1:type field2:type`

### In-context Relationships
  * `mix phx.gen.context Catalog Category categories title:string:unique`

### Gen other context --> cross-context dependencies
  * `mix phx.gen.context ShoppingCart Cart carts user_uuid:uuid:unique`


