# Test-3.rb

Created: Oct 26, 2020 9:47 PM
Updated: Nov 1, 2020 1:02 PM

Первый отчет memory_profiler:

```bash
(base) theendcomplete@N10L:~/Documents/projects/my/rails-optimization-task3$ bundle exec rspec spec/benchmarks/reload_json_benchmark.rb
Total allocated: 351818774 bytes (3606945 objects)
Total retained:  325072 bytes (2747 objects)

allocated memory by gem
-----------------------------------
 225572626  activerecord-5.2.3
  55090317  activesupport-5.2.3
  34205501  activemodel-5.2.3
  17553760  arel-9.0.0
  11403817  i18n-1.6.0
   2870308  rails-optimization-task3/lib
   2301380  set
   1451622  json
   1161946  logger
    153682  bootsnap-1.4.2
     36848  rails-optimization-task3/app
     14456  concurrent-ruby-1.1.5
       968  rake-12.3.2
       504  monitor
       504  mutex_m
       415  railties-5.2.3
       120  other

allocated memory by file
-----------------------------------
  44767201  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql_adapter.rb
  28318293  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb
  25421816  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb
  19116864  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb
  12801950  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb
   8679976  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/query_methods.rb
   8397808  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb
   8334640  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/where_clause.rb
   7794403  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb
   7562992  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb
   6123968  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb
   5754258  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb
   5547824  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/transactions.rb
   5238056  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract_adapter.rb
   5052264  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/querying.rb
   4937424  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/core.rb
   4419736  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/persistence.rb
   4413600  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/interpolate/ruby.rb
   4370612  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/backend/base.rb
   4304312  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/spawn_methods.rb
   4287102  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb
  

allocated memory by class
-----------------------------------
 109364800  Hash
  74928752  Array
  61517463  String
  42622720  PG::Result
   6469440  Proc
   5798696  Class
   4679168  ActiveRecord::Relation
   4528440  MatchData
   3706616  ActiveModel::Attribute::FromDatabase
   2911136  ActiveSupport::HashWithIndifferentAccess
   2838528  Enumerator
   2440360  ActiveRecord::Relation::WhereClause
   2066696  ActiveRecord::Relation::QueryAttribute
   2034080  ActiveModel::Attribute::FromUser
   1966751  Regexp
   1529136  Thread::Backtrace
   1528736  Time
   1298208  ActiveSupport::Notifications::Event
   1293560  Arel::Attributes::Attribute
   1283400  Arel::Nodes::BindParam
    972288  ActiveRecord::Result
    921128  Arel::Nodes::SelectCore
    867600  Service
    779416  Arel::Nodes::SelectStatement
    720992  ActiveModel::LazyAttributeHash
    708160  ActiveModel::Attribute::WithCastValue
    684600  ActiveModel::AttributeSet
    656016  ActiveRecord::AssociationRelation
    624000  ActiveRecord::Relation::WhereClauseFactory
    606880  ActiveSupport::Callbacks::Filters::Environment
    585744  ActiveRecord::Associations::BelongsToAssociation
    572960  ActiveRecord::Relation::Merger
    524880  Arel::Collectors::Bind
    524880  Arel::Collectors::Composite
    524880  Arel::Collectors::SQLString
    466360  Arel::Nodes::Equality
    463232  HABTM_Services
    396680  Set
    396640  ActiveModel::AttributeMutationTracker
    354280  Arel::Nodes::JoinSource
    354280  Arel::Nodes::SqlLiteral
    354280  Arel::SelectManager
    354120  Arel::Nodes::And
    354080  Arel::Nodes::Limit
    354080  Arel::Nodes::Top
    307088  Arel::Nodes::InsertStatement
    290960  ActiveModel::Errors
    240488  City
    191704  Bus
    176000  Trip

allocated objects by gem
-----------------------------------
   2187313  activerecord-5.2.3
    576369  activesupport-5.2.3
    386334  activemodel-5.2.3
    324041  arel-9.0.0
     67832  i18n-1.6.0
     21232  json
     17467  rails-optimization-task3/lib
     13511  logger
      9922  set
      2704  bootsnap-1.4.2
        92  concurrent-ruby-1.1.5
        91  rails-optimization-task3/app
        13  rake-12.3.2
         7  monitor
         7  mutex_m
         7  railties-5.2.3
         3  other
```

Профилирование CPU не дало большей подсказки, чем дано в ридми, а значит - образаемся к activerecord_import:



![case-study/Untitled.png](case-study/Untitled.png)

Замена JSON.load на OJ помогла выиграть пару секунд:

```bash
(base) theendcomplete@N10L:~/Documents/projects/my/rails-optimization-task3$ bundle exec rspec spec/benchmarks/reload_json_memory_benchmark.rb
Total allocated: 351932631 bytes (3606943 objects)
Total retained:  325152 bytes (2749 objects)

allocated memory by gem
-----------------------------------
 225572626  activerecord-5.2.3
  55090317  activesupport-5.2.3
  34205501  activemodel-5.2.3
  17553760  arel-9.0.0
  11403817  i18n-1.6.0
   4435787  rails-optimization-task3/lib
   2301380  set
   1161946  logger
    153682  bootsnap-1.4.2
     36848  rails-optimization-task3/app
     14456  concurrent-ruby-1.1.5
       968  rake-12.3.2
       504  monitor
       504  mutex_m
       415  railties-5.2.3
       120  other

allocated memory by file
-----------------------------------
  44767201  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql_adapter.rb
  28318293  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb
  25421816  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb
  19116864  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb
  12801950  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb
   8679976  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/query_methods.rb
   8397808  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb
   8334640  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/where_clause.rb
   7794403  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb
   7562992  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb
   6123968  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb
   5754258  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb
   5547824  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/transactions.rb
   5238056  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract_adapter.rb
   5052264  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/querying.rb
   4937424  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/core.rb
   4435787  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/lib/tasks/utils.rake
   4419736  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/persistence.rb
   4413600  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/interpolate/ruby.rb
   4370612  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/backend/base.rb
   4304312  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/spawn_methods.rb
   4287102  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb
   4286896  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/query_cache.rb
   4153440  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/hash_with_indifferent_access.rb
   3801680  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_set/builder.rb
   3716088  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb
   3678256  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/notifications/instrumenter.rb
   3608932  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/tagged_logging.rb
   3586904  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/to_sql.rb
   3505818  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/log_subscriber.rb
   3396072  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_set.rb
   3170056  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/result.rb
   3082060  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/logger.rb
   2955176  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/collection_association.rb
   2920968  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/subscriber.rb
   2905840  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb
   2890256  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/aggregations.rb
   2657824  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/table_metadata.rb
   2516568  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb
   2442960  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_assignment.rb
   2442960  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/reverse_merge.rb
   2333032  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/object/deep_dup.rb
   2301380  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/set.rb
   2202080  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/merger.rb
   2177334  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb
   2148888  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/except.rb
   2125680  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/nodes/select_core.rb
   2009880  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/database_statements.rb
   1906776  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/select_manager.rb
   1905280  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb

allocated memory by location
-----------------------------------
  24647088  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql_adapter.rb:622
  17934336  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql_adapter.rb:611
  15340704  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
  10150080  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:404
   6799224  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:29
   5722048  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:25
   4885456  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:189
   4413600  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/interpolate/ruby.rb:23
   4400344  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:508
   4204089  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:35
   4183432  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:132
   3608932  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/tagged_logging.rb:23
   3591824  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:437
   3590896  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:36
   3505818  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/log_subscriber.rb:109
   3312384  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:159
   3244000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:198
   3138536  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract_adapter.rb:570
   3137336  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/notifications/instrumenter.rb:60
   3135000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
   3132928  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:82
   3082060  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/logger.rb:104
   3068772  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:43
   2905840  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107
   2890256  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/aggregations.rb:25
   2890256  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb:265
   2890256  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/core.rb:542
   2846640  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:806
   2586920  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:75
   2452868  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:89
   2442960  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/transactions.rb:404
   2442960  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/reverse_merge.rb:15
   2400384  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/query_methods.rb:877
   2363344  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb:9
   2300744  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/set.rb:94
   2291840  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/where_clause.rb:25
   2143448  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/query_cache.rb:106
   2143448  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/query_cache.rb:108
   2137776  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/spawn_methods.rb:11
   2114600  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:425
   2111200  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb:124
   2111200  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/table_metadata.rb:14
   2034232  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_set.rb:37
   2034080  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb:13
   2032640  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb:60
   2006320  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:103
   1900776  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_set/builder.rb:25
   1900776  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/persistence.rb:71
   1900776  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/result.rb:134
   1879152  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/collectors/plain_string.rb:6

allocated memory by class
-----------------------------------
 109364568  Hash
  74928752  Array
  61632680  String
  42622720  PG::Result
   6469440  Proc
   5798696  Class
   4679168  ActiveRecord::Relation
   4528440  MatchData
   3706616  ActiveModel::Attribute::FromDatabase
   2911136  ActiveSupport::HashWithIndifferentAccess
   2838528  Enumerator
   2440360  ActiveRecord::Relation::WhereClause
   2066696  ActiveRecord::Relation::QueryAttribute
   2034080  ActiveModel::Attribute::FromUser
   1966751  Regexp
   1529136  Thread::Backtrace
   1528736  Time
   1298208  ActiveSupport::Notifications::Event
   1293560  Arel::Attributes::Attribute
   1283400  Arel::Nodes::BindParam
    972288  ActiveRecord::Result
    921128  Arel::Nodes::SelectCore
    867600  Service
    779416  Arel::Nodes::SelectStatement
    720992  ActiveModel::LazyAttributeHash
    708160  ActiveModel::Attribute::WithCastValue
    684600  ActiveModel::AttributeSet
    656016  ActiveRecord::AssociationRelation
    624000  ActiveRecord::Relation::WhereClauseFactory
    606880  ActiveSupport::Callbacks::Filters::Environment
    585744  ActiveRecord::Associations::BelongsToAssociation
    572960  ActiveRecord::Relation::Merger
    524880  Arel::Collectors::Bind
    524880  Arel::Collectors::Composite
    524880  Arel::Collectors::SQLString
    466360  Arel::Nodes::Equality
    463232  HABTM_Services
    396680  Set
    396640  ActiveModel::AttributeMutationTracker
    354280  Arel::Nodes::JoinSource
    354280  Arel::Nodes::SqlLiteral
    354280  Arel::SelectManager
    354120  Arel::Nodes::And
    354080  Arel::Nodes::Limit
    354080  Arel::Nodes::Top
    307088  Arel::Nodes::InsertStatement
    290960  ActiveModel::Errors
    240488  City
    191704  Bus
    176000  Trip

allocated objects by gem
-----------------------------------
   2187313  activerecord-5.2.3
    576369  activesupport-5.2.3
    386334  activemodel-5.2.3
    324041  arel-9.0.0
     67832  i18n-1.6.0
     38697  rails-optimization-task3/lib
     13511  logger
      9922  set
      2704  bootsnap-1.4.2
        92  concurrent-ruby-1.1.5
        91  rails-optimization-task3/app
        13  rake-12.3.2
         7  monitor
         7  mutex_m
         7  railties-5.2.3
         3  other

allocated objects by file
-----------------------------------
    263001  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb
    209177  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb
    195606  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb
    177022  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/where_clause.rb
    162249  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/query_methods.rb
    136835  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb
    114236  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb
    110067  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb
    101607  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb
     89263  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb
     72646  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb
     66041  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract_adapter.rb
     55052  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/merger.rb
     54739  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/persistence.rb
     54092  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/subscriber.rb
     53142  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/nodes/select_core.rb
     52925  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/querying.rb
     50813  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/collection_association.rb
     50236  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/database_statements.rb
     48985  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/to_sql.rb
     47632  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb
     44508  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/quoting.rb
     43280  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql_adapter.rb
     43098  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/spawn_methods.rb
     42146  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/core.rb
     39657  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/result.rb
     39443  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_set.rb
     38697  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/lib/tasks/utils.rake
     37041  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/select_manager.rb
     36555  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_set/builder.rb
     35754  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb
     35700  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/table.rb
     33333  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb
     32846  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/association.rb
     31974  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/where_clause_factory.rb
     31508  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb
     30972  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/hash_with_indifferent_access.rb
     30602  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/postgresql.rb
     29576  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb
     27046  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/notifications/instrumenter.rb
     27022  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/log_subscriber.rb
     27022  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/tagged_logging.rb
     26571  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/nodes/select_statement.rb
     26386  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/backend/base.rb
     26320  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/has_many_through_association.rb
     25977  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/timestamp.rb
     24520  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/interpolate/ruby.rb
     22244  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/association_scope.rb
     21047  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/object/deep_dup.rb
     20676  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb

allocated objects by location
-----------------------------------
    106468  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
     85004  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:35
     78375  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
     72646  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107
     71166  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:806
     57296  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/where_clause.rb:25
     52865  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:404
     52865  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:425
     48046  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:89
     40569  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/subscriber.rb:100
     40550  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:198
     36848  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/collection_association.rb:481
     35624  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:83
     33950  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:132
     32339  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/table.rb:81
     31974  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/where_clause.rb:13
     30988  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/quoting.rb:161
     30988  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:58
     30602  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/postgresql.rb:49
     29542  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb:9
     29307  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:29
     28648  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/where_clause.rb:109
     27022  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/log_subscriber.rb:109
     27022  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/tagged_logging.rb:23
     26244  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract_adapter.rb:612
     25870  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_set.rb:37
     25426  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb:13
     25426  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb:71
     25079  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:103
     24664  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:25
     24520  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/interpolate/ruby.rb:23
     23848  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/result.rb:128
     23446  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:17
     23233  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb:60
     23233  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb:61
     22137  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql_adapter.rb:447
     21460  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:424
     21235  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/lib/tasks/utils.rake:6
     21058  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:180
     21058  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:189
     21058  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:191
     20529  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:279
     20072  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb:71
     19012  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/core.rb:285
     18967  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:508
     18095  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/to_sql.rb:820
     17714  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/nodes/select_statement.rb:8
     16775  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/object/deep_dup.rb:16
     16472  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/to_sql.rb:729
     16329  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:46

allocated objects by class
-----------------------------------
   1564289  Array
    813953  String
    470568  Hash
     80868  Proc
     61009  ActiveRecord::Relation::WhereClause
     46334  ActiveModel::Attribute::FromDatabase
     39133  ActiveRecord::Relation
     32339  Arel::Attributes::Attribute
     32085  Arel::Nodes::BindParam
     25426  ActiveModel::Attribute::FromUser
     23620  ActiveRecord::Relation::QueryAttribute
     22176  Enumerator
     17776  Time
     17115  ActiveModel::AttributeSet
     16173  MatchData
     15600  ActiveRecord::Relation::WhereClauseFactory
     15172  ActiveSupport::Callbacks::Filters::Environment
     14324  ActiveRecord::Relation::Merger
     13527  PG::Result
     13523  ActiveSupport::Notifications::Event
     13504  ActiveRecord::Result
     13122  Arel::Collectors::Bind
     13122  Arel::Collectors::Composite
     13122  Arel::Collectors::SQLString
     12623  Class
     12548  ActiveSupport::HashWithIndifferentAccess
     11659  Arel::Nodes::Equality
      9917  Set
      9916  ActiveModel::AttributeMutationTracker
      8857  Arel::Nodes::JoinSource
      8857  Arel::Nodes::SelectCore
      8857  Arel::Nodes::SelectStatement
      8857  Arel::Nodes::SqlLiteral
      8857  Arel::SelectManager
      8853  Arel::Nodes::And
      8852  ActiveModel::Attribute::WithCastValue
      8852  Arel::Nodes::Limit
      8852  Arel::Nodes::Top
      8193  ActiveModel::LazyAttributeHash
      7274  ActiveModel::Errors
      5826  Service
      5652  ActiveRecord::AssociationRelation
      5632  ActiveRecord::Associations::BelongsToAssociation
      4265  Arel::InsertManager
      4265  Arel::Nodes::InsertStatement
      4265  Arel::Nodes::Values
      3361  Arel::Table
      2632  HABTM_Services
      2461  Regexp
      2452  I18n::MissingTranslation

retained memory by gem
-----------------------------------
    143695  activerecord-5.2.3
     75262  activesupport-5.2.3
     30376  rails-optimization-task3/app
     24952  bootsnap-1.4.2
     17577  i18n-1.6.0
     15687  activemodel-5.2.3
     14456  concurrent-ruby-1.1.5
      1056  arel-9.0.0
       868  set
       504  monitor
       504  mutex_m
       175  railties-5.2.3
        40  other

retained memory by file
-----------------------------------
     37936  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb
     30568  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb
     15714  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb
     14934  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb
     14869  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/core_ext/hash.rb
     14033  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb
     11216  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/concurrent-ruby-1.1.5/lib/concurrent/collection/map/non_concurrent_map_backend.rb
      9463  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb
      9360  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/redefine_method.rb
      8704  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/core.rb
      8328  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/bus.rb
      8097  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb
      8096  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/service.rb
      7424  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/array/extract_options.rb
      7192  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/except.rb
      6963  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb
      6480  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/trip.rb
      5210  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/statement_cache.rb
      5012  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb
      4872  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/city.rb
      4624  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/schema_statements.rb
      4604  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/join_dependency.rb
      4528  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb
      3936  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb
      3584  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_decorators.rb
      3440  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb
      3375  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/loaded_features_index.rb
      3312  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/legacy_yaml_adapter.rb
      3240  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/concurrent-ruby-1.1.5/lib/concurrent/collection/map/mri_map_backend.rb
      2768  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb
      2600  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/application_record.rb
      2568  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/association_scope.rb
      2024  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations.rb
      1983  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb
      1966  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/has_many_through_association.rb
      1952  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb
      1848  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb
      1656  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/belongs_to.rb
      1624  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/object/deep_dup.rb
      1502  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/has_many_association.rb
      1440  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/schema_cache.rb
      1390  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/alias_tracker.rb
      1360  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n.rb
      1344  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb
      1339  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/dynamic_matchers.rb
      1310  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/belongs_to_association.rb
      1270  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/read.rb
      1265  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql_adapter.rb
      1226  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/delegation.rb
      1174  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/join_dependency/join_part.rb

retained memory by location
-----------------------------------
     22168  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:17
     14033  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
     13600  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:47
     11136  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/concurrent-ruby-1.1.5/lib/concurrent/collection/map/non_concurrent_map_backend.rb:16
     11136  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/core_ext/hash.rb:15
      9360  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/redefine_method.rb:29
      8904  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:49
      8719  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
      7424  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/array/extract_options.rb:30
      7264  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/bus.rb:1
      7264  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/service.rb:1
      7192  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/except.rb:13
      6963  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28
      5720  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/core.rb:226
      5568  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:841
      5344  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/trip.rb:1
      4832  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/city.rb:1
      4512  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:289
      4240  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:424
      3375  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/loaded_features_index.rb:109
      3360  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:42
      3240  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/concurrent-ruby-1.1.5/lib/concurrent/collection/map/mri_map_backend.rb:14
      3024  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:462
      2800  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:450
      2786  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:104
      2786  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:99
      2720  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:153
      2600  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/application_record.rb:1
      2480  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:483
      2184  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/core.rb:148
      2053  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/core_ext/hash.rb:30
      2016  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:464
      1983  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
      1904  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_decorators.rb:67
      1904  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/schema_statements.rb:653
      1886  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/join_dependency.rb:261
      1880  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:302
      1680  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_decorators.rb:45
      1656  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:31
      1624  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations.rb:278
      1624  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:11
      1624  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/object/deep_dup.rb:44
      1566  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/association_scope.rb:167
      1560  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/statement_cache.rb:121
      1536  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/belongs_to.rb:163
      1512  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:82
      1502  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/has_many_association.rb:143
      1502  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/has_many_through_association.rb:226
      1464  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:22
      1456  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:559

retained memory by class
-----------------------------------
     85928  Class
     66063  String
     61480  Hash
     26400  Proc
     21104  Array
     13600  ActiveRecord::AttributeMethods::GeneratedAttributeMethods
     13456  Module
      6840  Thread::Mutex
      4512  ActiveSupport::Callbacks::Callback
      3816  ActiveSupport::Callbacks::CallTemplate
      2521  Regexp
      2080  Symbol
      1904  ActiveRecord::ConnectionAdapters::PostgreSQLColumn
      1800  Concurrent::Map
      1360  ActiveRecord::ConnectionAdapters::PostgreSQLTypeMetadata
      1360  ActiveRecord::ConnectionAdapters::SqlTypeMetadata
      1344  ActiveModel::Attribute::FromDatabase
      1200  ActiveSupport::Callbacks::CallbackChain
      1040  ActiveSupport::Callbacks::CallbackSequence
       936  ActiveRecord::Reflection::BelongsToReflection
       720  ActiveRecord::Reflection::HasManyReflection
       504  Monitor
       480  ActiveSupport::Callbacks::Conditionals::Value
       440  ActiveRecord::Validations::PresenceValidator
       400  ActiveRecord::PredicateBuilder::ArrayHandler
       280  ActiveRecord::AttributeDecorators::TypeDecorator
       240  ActiveRecord::Reflection::HasAndBelongsToManyReflection
       200  ActiveModel::AttributeSet
       200  ActiveRecord::PredicateBuilder
       200  ActiveRecord::PredicateBuilder::BaseHandler
       200  ActiveRecord::PredicateBuilder::BasicObjectHandler
       200  ActiveRecord::PredicateBuilder::RangeHandler
       200  ActiveRecord::PredicateBuilder::RelationHandler
       200  ActiveRecord::TableMetadata
       200  ActiveRecord::TypeCaster::Map
       200  Arel::Table
       160  ActiveModel::AttributeMethods::ClassMethods::AttributeMethodMatcher::AttributeMethodMatch
       144  ActiveModel::Name
       120  ActiveModel::AttributeSet::Builder
       120  ActiveModel::AttributeSet::YAMLEncoder
       120  ActiveRecord::Reflection::ThroughReflection
        80  ActiveModel::Validations::InclusionValidator
        80  ActiveModel::Validations::NumericalityValidator
        80  ActiveRecord::Associations::Builder::HasAndBelongsToMany::JoinTableResolver::KnownTable
        80  ActiveRecord::Relation::QueryAttribute
        80  ActiveRecord::Validations::UniquenessValidator
        40  ActiveModel::Validations::FormatValidator
        40  ActiveRecord::Associations::AssociationScope
        40  ActiveRecord::ConnectionAdapters::TransactionState
        40  ActiveRecord::Reflection::AbstractReflection::JoinKeys

retained objects by gem
-----------------------------------
       922  activerecord-5.2.3
       813  activesupport-5.2.3
       419  bootsnap-1.4.2
       287  activemodel-5.2.3
       122  i18n-1.6.0
        92  concurrent-ruby-1.1.5
        54  rails-optimization-task3/app
        18  arel-9.0.0
         7  monitor
         7  mutex_m
         6  set
         1  other
         1  railties-5.2.3

retained objects by file
-----------------------------------
       461  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb
       250  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb
       191  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb
       143  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb
       120  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb
       117  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/redefine_method.rb
       102  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/core_ext/hash.rb
        97  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb
        76  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb
        70  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb
        66  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb
        57  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb
        53  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/core.rb
        51  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/schema_statements.rb
        47  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/concurrent-ruby-1.1.5/lib/concurrent/collection/map/non_concurrent_map_backend.rb
        45  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb
        45  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/concurrent-ruby-1.1.5/lib/concurrent/collection/map/mri_map_backend.rb
        42  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_decorators.rb
        42  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb
        36  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb
        34  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb
        32  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/array/extract_options.rb
        31  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/except.rb
        24  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/callbacks.rb
        22  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb
        22  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb
        21  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/statement_cache.rb
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/read.rb
        19  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/loaded_features_index.rb
        18  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations/with.rb
        17  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb
        17  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations.rb
        17  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/bus.rb
        16  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/write.rb
        16  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/service.rb
        16  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/trip.rb
        15  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/time_zone_conversion.rb
        14  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/quoting.rb
        14  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n.rb
        13  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql_adapter.rb
        13  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/visitor.rb
        12  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/schema_cache.rb
        11  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/join_dependency.rb
        11  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/inheritance.rb
        11  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/delegation.rb
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb
         9  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/association_scope.rb
         9  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/legacy_yaml_adapter.rb
         8  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/type/type_map.rb

retained objects by location
-----------------------------------
       250  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
       174  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
       143  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28
       117  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/redefine_method.rb:29
        53  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:424
        50  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:450
        50  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/core_ext/hash.rb:30
        47  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:289
        47  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:302
        45  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
        45  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/concurrent-ruby-1.1.5/lib/concurrent/collection/map/mri_map_backend.rb:14
        45  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/concurrent-ruby-1.1.5/lib/concurrent/collection/map/non_concurrent_map_backend.rb:16
        45  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/core_ext/hash.rb:15
        42  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:17
        40  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:104
        40  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:99
        36  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:464
        35  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:301
        34  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:153
        32  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/array/extract_options.rb:30
        31  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:483
        31  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/except.rb:13
        30  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb:47
        28  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_decorators.rb:45
        24  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
        21  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/core.rb:148
        21  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:82
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:35
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:36
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/read.rb:36
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:181
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:452
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:101
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:96
        19  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/loaded_features_index.rb:109
        18  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations/with.rb:86
        18  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:462
        17  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb:87
        17  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/schema_statements.rb:653
        17  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/schema_statements.rb:668
        17  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/schema_statements.rb:675
        17  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400
        15  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:22
        15  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:559
        15  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:560
        15  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:627
        14  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_decorators.rb:67
        14  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/quoting.rb:47
        14  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:433

retained objects by class
-----------------------------------
      1108  String
       420  Array
       330  Proc
       235  Hash
        95  Class
        95  Thread::Mutex
        53  ActiveSupport::Callbacks::CallTemplate
        52  Symbol
        47  ActiveSupport::Callbacks::Callback
        45  Concurrent::Map
        22  Module
        17  ActiveModel::Attribute::FromDatabase
        17  ActiveRecord::ConnectionAdapters::PostgreSQLColumn
        17  ActiveRecord::ConnectionAdapters::PostgreSQLTypeMetadata
        17  ActiveRecord::ConnectionAdapters::SqlTypeMetadata
        15  ActiveSupport::Callbacks::CallbackChain
        13  ActiveSupport::Callbacks::CallbackSequence
        12  ActiveSupport::Callbacks::Conditionals::Value
        11  ActiveRecord::Validations::PresenceValidator
        10  ActiveRecord::PredicateBuilder::ArrayHandler
         7  ActiveRecord::AttributeDecorators::TypeDecorator
         7  ActiveRecord::AttributeMethods::GeneratedAttributeMethods
         7  ActiveRecord::Reflection::BelongsToReflection
         7  Monitor
         5  ActiveModel::AttributeSet
         5  ActiveRecord::PredicateBuilder
         5  ActiveRecord::PredicateBuilder::BaseHandler
         5  ActiveRecord::PredicateBuilder::BasicObjectHandler
         5  ActiveRecord::PredicateBuilder::RangeHandler
         5  ActiveRecord::PredicateBuilder::RelationHandler
         5  ActiveRecord::Reflection::HasManyReflection
         5  ActiveRecord::TableMetadata
         5  ActiveRecord::TypeCaster::Map
         5  Arel::Table
         4  ActiveModel::AttributeMethods::ClassMethods::AttributeMethodMatcher::AttributeMethodMatch
         4  Regexp
         3  ActiveModel::AttributeSet::Builder
         3  ActiveModel::AttributeSet::YAMLEncoder
         2  ActiveModel::Validations::InclusionValidator
         2  ActiveModel::Validations::NumericalityValidator
         2  ActiveRecord::Associations::Builder::HasAndBelongsToMany::JoinTableResolver::KnownTable
         2  ActiveRecord::Reflection::HasAndBelongsToManyReflection
         2  ActiveRecord::Reflection::ThroughReflection
         2  ActiveRecord::Validations::UniquenessValidator
         1  ActiveModel::Name
         1  ActiveModel::Validations::FormatValidator
         1  ActiveRecord::Associations::AssociationScope
         1  ActiveRecord::ConnectionAdapters::TransactionState
         1  ActiveRecord::Reflection::AbstractReflection::JoinKeys
         1  ActiveRecord::Relation::QueryAttribute

Allocated String Report
-----------------------------------
     44985  "buses_services"
     36131  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
      5264  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/collection_association.rb:481
      2632  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/has_many_through_association.rb:76
       937  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:405
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:99
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:28
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb:1840
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:181
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:212
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/schema_cache.rb:114
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:352
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:37
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400

     34687  "name"
      6616  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:83
      6616  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/result.rb:128
      6239  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:219
      6229  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb:29
      6229  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:46
      2662  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
        32  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:40
        14  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/validations/uniqueness.rb:102
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/validations/uniqueness.rb:73
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:406
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:96
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:97
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/quoting.rb:68

     28157  "id"
     11881  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:83
      8193  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_set/builder.rb:115
      7616  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/result.rb:128
       387  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/validations/uniqueness.rb:26
        60  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:406
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/quoting.rb:47

     27009  "service"
     24348  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
      2632  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/has_many_through_association.rb:61
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:405
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:72
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:94
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:107
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:108
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:115
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:116
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:98
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:19
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:20
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:28
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:33
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:36
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:37
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:181
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:212
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:352
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:37
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:655
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:662

     24862  "1"
     15501  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107
      9356  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/type/string.rb:18
         2  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/lib/tasks/utils.rake:6
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:89

     19650  ""
     13511  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/tagged_logging.rb:23
      3361  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/table.rb:22
      1842  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:141
       614  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:140
       252  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:375
        12  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/read.rb:38
        12  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/write.rb:23
         7  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:43
         7  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/loaded_features_index.rb:98
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/loaded_features_index.rb:101
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/inheritance.rb:185
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/inheritance.rb:190
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb:513
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/cache.rb:65
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:28
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/schema_statements.rb:768
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/dynamic_matchers.rb:38
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n.rb:378

     16968  "Service"
      7657  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:85
      4616  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/querying.rb:41
      4616  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/querying.rb:48
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/persistence.rb:187
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:94
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:81
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/suppressor.rb:44
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:72
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/inheritance.rb:190
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:409
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:487
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:273
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:328
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:112
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:98
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/primary_key.rb:87
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb:513
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/introspection.rb:13
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

     16633  "Bus"
      4452  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:94
      2227  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:85
      2226  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:81
      1613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/suppressor.rb:44
      1612  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:97
      1226  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/persistence.rb:187
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/querying.rb:41
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/querying.rb:48
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/backend/base.rb:48
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/interpolate/ruby.rb:23
         8  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/inheritance.rb:185
         8  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:273
         6  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:328
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:494
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:487
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:72
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/inheritance.rb:190
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:409
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/anonymous.rb:28
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:680
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/naming.rb:149
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:112
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:98
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/primary_key.rb:87
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb:513
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:612
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:666
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:114
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/introspection.rb:13
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:130
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

     15549  "2"
     15113  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107
       428  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/type/string.rb:18
         3  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/lib/tasks/utils.rake:6
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:89

     14701  "number"
      3226  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
      2613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:219
      1613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/validations/uniqueness.rb:102
      1613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/validations/uniqueness.rb:73
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:83
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb:29
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/result.rb:128
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:46
      1000  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/lib/tasks/utils.rake:6
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:40
        16  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:406
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/quoting.rb:68
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28

     13525  "sql"
     13523  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/subscriber.rb:100
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

     13523  "active_record"
     13523  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/subscriber.rb:100

     13118  "$1"
     13118  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/postgresql.rb:49

     13097  "$2"
     13097  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/postgresql.rb:49

     11998  "model"
      3065  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:140
      1839  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:141
      1226  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/translation.rb:46
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:83
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/result.rb:128
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:40
      1000  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/lib/tasks/utils.rake:6
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:407
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:415
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:145
        16  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
         6  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n.rb:378
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:406
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24

      9808  "(?-mix:%%)|(?-mix:%\\{(\\w+)\\})|(?-mix:%<(\\w+)>(.*?\\d*\\.?\\d*[bBdiouxXeEfgGcps]))"
      9808  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/interpolate/ruby.rb:23

      9239  "services"
      5264  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/collection_association.rb:481
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:40
      1000  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/lib/tasks/utils.rake:6
       936  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:282
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:405
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:352
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:72
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb:1841
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb:1856
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:107
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:108
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:115
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:116
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:54
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:55
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:64
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:65
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:72
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:88
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:99
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:181
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:212
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/schema_cache.rb:114
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb:513
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:37

      8852  "\"LIMIT\""
      8852  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37

      8852  "[\"LIMIT\", 1]"
      8852  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37

      7694  "0.2"
      7694  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107

      7020  "duration_minutes"
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:382
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations/numericality.rb:128
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations/numericality.rb:26
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/before_type_cast.rb:49
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:40
      1000  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/lib/tasks/utils.rake:6
        16  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:406
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

      7020  "price_cents"
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:382
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations/numericality.rb:128
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations/numericality.rb:26
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/before_type_cast.rb:49
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:40
      1000  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/lib/tasks/utils.rake:6
        16  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:406
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

      6916  "bus"
      3002  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:40
      1000  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/lib/tasks/utils.rake:6
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:407
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:408
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/translation.rb:58
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:405
         8  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:94
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:140
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n.rb:378
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:141
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:107
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:108
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:115
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:116
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:19
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:20
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:28
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:29
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:32
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:33
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:36
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:37
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:181
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:212
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:352
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:37
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:72
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/naming.rb:196
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:98
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:655
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:662
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:145
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

      6313  "\"name\""
      6259  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
        32  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:372
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/to_sql.rb:128
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/quoting.rb:47

      6139  "City"
      2021  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:85
      2000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/querying.rb:41
      2000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/querying.rb:48
        40  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:94
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/persistence.rb:187
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:81
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/suppressor.rb:44
         9  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:97
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/inheritance.rb:190
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:409
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:487
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:273
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:328
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/primary_key.rb:87
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb:513
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:114
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/introspection.rb:13
         1  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/trip.rb:4
         1  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/trip.rb:5

      6009  "empty?"
      6000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:454
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:400
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:401

      5275  "bus_id="
      2632  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_assignment.rb:49
      2632  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:279
         6  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/write.rb:26
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/write.rb:20
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:406

      5270  "after_add"
      5264  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/collection_association.rb:481
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

      5270  "before_add"
      5264  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/collection_association.rb:481
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

      5268  "Bus::HABTM_Services"
      5264  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/persistence.rb:187
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/inheritance.rb:190
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb:1828
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:112

      5264  "to_ary"
      5264  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:279

      5021  "to"
      3000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:40
      1000  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/lib/tasks/utils.rake:6
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:107
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:108
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:115
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:116
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:19
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:20
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:28
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:33
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:36
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:37
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:181
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:212
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:352
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:37
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:662
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:405

      5019  "from"
      3000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:40
      1000  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/lib/tasks/utils.rake:6
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:107
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:108
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:115
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:116
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:19
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:20
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:28
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:33
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:36
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:37
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:181
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:212
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:352
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:37
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:662
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:405
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

      4950  "0.1"
      4950  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107

      4616  "Service Load"
      4616  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/querying.rb:41

      4242  "3"
      3752  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107
       485  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/type/string.rb:18
         2  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/lib/tasks/utils.rake:6
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:89

      4230  "\"services\".*"
      4230  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/to_sql.rb:729

      4229  "\e[1m\e[34mSELECT  \"services\".* FROM \"services\" WHERE \"services\".\"name\" = $1 LIMIT $2\e[0m"
      4229  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/log_subscriber.rb:109

      4229  "\"$user\", public-SELECT  \"services\".* FROM \"services\" WHERE \"services\".\"name\" = $1 LIMIT $2"
      4229  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql_adapter.rb:666

      4229  "\"services\".\"name\""
      4229  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/to_sql.rb:729

      4229  "SELECT  \"services\".* FROM \"services\" WHERE \"services\".\"name\" = $1 LIMIT $2"
      4229  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/collectors/plain_string.rb:6

      4052  "\"bus_id\""
      4019  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
        32  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:372
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/quoting.rb:47

      4033  "Trip"
      2000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/persistence.rb:187
      1001  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:85
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/suppressor.rb:48
         8  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/inheritance.rb:185
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:494
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:273
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:612
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:409
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/anonymous.rb:28
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:680
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:328
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/primary_key.rb:87
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb:513
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/introspection.rb:13
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:487
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

      3803  "4"
      3311  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107
       487  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/type/string.rb:18
         2  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/lib/tasks/utils.rake:6
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:89

      3791  "6"
      3302  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107
       489  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37

      3759  "5"
      3280  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107
       471  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/type/string.rb:18
         3  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/lib/tasks/utils.rake:6
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:89

      3692  "inclusion"
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:407
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:408
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:410
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:415
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:416
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/backend/simple.rb:98
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n.rb:378
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:72
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations/validates.rb:116
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28

      3281  "\e[1m\e[36mService Load (0.1ms)\e[0m"
      3281  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/log_subscriber.rb:109

      3281  "Service Load (0.1ms)"
      3281  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:28

      3244  "\"number\""
      3226  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
        16  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:372
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/quoting.rb:47

Retained String Report
-----------------------------------
        18  "validate"
        18  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:462

        11  "id"
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/quoting.rb:47

        10  "buses"
         6  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/naming.rb:163
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/schema_cache.rb:114
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb:513
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

         7  "bus_id"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/time_zone_conversion.rb:84
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:662
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:252

         7  "integer"
         7  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24

         5  "bigint"
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24

         5  "buses_services"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:28
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/schema_cache.rb:114
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

         5  "character varying"
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24

         5  "from_id"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/time_zone_conversion.rb:84
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:662

         5  "service_id"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/time_zone_conversion.rb:84
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:662

         5  "services"
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/schema_cache.rb:114
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb:513

         5  "to_id"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/time_zone_conversion.rb:84
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:662

         4  ""
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28

         4  "empty?"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:401
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:454

         4  "trips"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/schema_cache.rb:114
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb:513
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

         3  "Bus"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/naming.rb:149
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:130
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:72

         3  "City"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/trip.rb:4
         1  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/trip.rb:5

         3  "bus"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/naming.rb:196
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:94

         3  "name"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29

         2  "\"name\""
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/quoting.rb:47

         2  "\"number\""
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/quoting.rb:47

         2  "%n %u"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28

         2  ","
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28

         2  "."
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/application_record"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/set.rb:349
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:353

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/application_record.rb"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:22

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/bus"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/set.rb:349
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:353

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/bus.rb"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:22

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/city"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/set.rb:349
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:353

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/city.rb"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:22

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/service"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/set.rb:349
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:353

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/service.rb"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:22

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/trip"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/set.rb:349
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:353

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/trip.rb"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:22

         2  "ATTR_0727963656f53656e64737"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29

         2  "ATTR_3747162747f54796d656"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29

         2  "ATTR_37562767963656f59646"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29

         2  "ATTR_465727164796f6e6f5d696e657475637"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29

         2  "Bus::HABTM_Services"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb:1828
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:112

         2  "HABTM_Buses"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb:1828
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:88

         2  "HABTM_Services"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb:1828
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:88

         2  "May"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28

         2  "SELECT \"services\".* FROM \"services\" INNER JOIN \"buses_services\" ON \"services\".\"id\" = \"buses_services\".\"service_id\" WHERE \"buses_services\".\"bus_id\" = $1"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/database_statements.rb:39
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/collectors/plain_string.rb:6

         2  "Service::HABTM_Buses"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb:1828
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:112

         2  "Validation failed: %{errors}"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28

         2  "after_add_for_buses"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:96

         2  "after_add_for_buses_services"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:96

         2  "after_add_for_services"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:96

         2  "after_add_for_services_buses"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:96

         2  "after_add_for_trips"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:96

.

Finished in 27.05 seconds (files took 1.61 seconds to load)
1 example, 0 failures

#После 

(base) theendcomplete@N10L:~/Documents/projects/my/rails-optimization-task3$ bundle exec rspec spec/benchmarks/reload_json_memory_benchmark.rb
^[[5FTotal allocated: 351933991 bytes (3606944 objects)
Total retained:  325200 bytes (2747 objects)

allocated memory by gem
-----------------------------------
 225572626  activerecord-5.2.3
  55090317  activesupport-5.2.3
  34205501  activemodel-5.2.3
  17553760  arel-9.0.0
  11403817  i18n-1.6.0
   2985525  rails-optimization-task3/lib
   2301380  set
   1451622  json
   1161946  logger
    153682  bootsnap-1.4.2
     36848  rails-optimization-task3/app
     14456  concurrent-ruby-1.1.5
       968  rake-12.3.2
       504  monitor
       504  mutex_m
       415  railties-5.2.3
       120  other

allocated memory by file
-----------------------------------
  44767201  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql_adapter.rb
  28318293  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb
  25421816  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb
  19116864  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb
  12801950  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb
   8679976  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/query_methods.rb
   8397808  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb
   8334640  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/where_clause.rb
   7794403  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb
   7562992  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb
   6123968  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb
   5754258  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb
   5547824  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/transactions.rb
   5238056  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract_adapter.rb
   5052264  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/querying.rb
   4937424  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/core.rb
   4419736  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/persistence.rb
   4413600  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/interpolate/ruby.rb
   4370612  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/backend/base.rb
   4304312  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/spawn_methods.rb
   4287102  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb
   4286896  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/query_cache.rb
   4153440  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/hash_with_indifferent_access.rb
   3801680  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_set/builder.rb
   3716088  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb
   3678256  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/notifications/instrumenter.rb
   3608932  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/tagged_logging.rb
   3586904  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/to_sql.rb
   3505818  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/log_subscriber.rb
   3396072  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_set.rb
   3170056  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/result.rb
   3082060  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/logger.rb
   2985525  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/lib/tasks/utils.rake
   2955176  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/collection_association.rb
   2920968  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/subscriber.rb
   2905840  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb
   2890256  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/aggregations.rb
   2657824  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/table_metadata.rb
   2516568  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb
   2442960  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_assignment.rb
   2442960  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/reverse_merge.rb
   2333032  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/object/deep_dup.rb
   2301380  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/set.rb
   2202080  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/merger.rb
   2177334  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb
   2148888  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/except.rb
   2125680  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/nodes/select_core.rb
   2009880  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/database_statements.rb
   1906776  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/select_manager.rb
   1905280  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb

allocated memory by location
-----------------------------------
  24647088  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql_adapter.rb:622
  17934336  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql_adapter.rb:611
  15340704  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
  10150080  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:404
   6799224  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:29
   5722048  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:25
   4885456  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:189
   4413600  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/interpolate/ruby.rb:23
   4400344  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:508
   4204089  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:35
   4183432  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:132
   3608932  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/tagged_logging.rb:23
   3591824  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:437
   3590896  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:36
   3505818  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/log_subscriber.rb:109
   3312384  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:159
   3244000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:198
   3138536  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract_adapter.rb:570
   3137336  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/notifications/instrumenter.rb:60
   3135000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
   3132928  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:82
   3082060  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/logger.rb:104
   3068772  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:43
   2905840  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107
   2890256  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/aggregations.rb:25
   2890256  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb:265
   2890256  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/core.rb:542
   2846640  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:806
   2586920  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:75
   2452868  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:89
   2442960  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/transactions.rb:404
   2442960  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/reverse_merge.rb:15
   2400384  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/query_methods.rb:877
   2363344  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb:9
   2300744  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/set.rb:94
   2291840  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/where_clause.rb:25
   2143448  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/query_cache.rb:106
   2143448  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/query_cache.rb:108
   2137776  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/spawn_methods.rb:11
   2114600  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:425
   2111200  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb:124
   2111200  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/table_metadata.rb:14
   2034232  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_set.rb:37
   2034080  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb:13
   2032640  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb:60
   2006320  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:103
   1900776  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_set/builder.rb:25
   1900776  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/persistence.rb:71
   1900776  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/result.rb:134
   1879152  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/collectors/plain_string.rb:6

allocated memory by class
-----------------------------------
 109364800  Hash
  74928752  Array
  61632680  String
  42622720  PG::Result
   6469440  Proc
   5798696  Class
   4679168  ActiveRecord::Relation
   4528440  MatchData
   3706616  ActiveModel::Attribute::FromDatabase
   2911136  ActiveSupport::HashWithIndifferentAccess
   2838528  Enumerator
   2440360  ActiveRecord::Relation::WhereClause
   2066696  ActiveRecord::Relation::QueryAttribute
   2034080  ActiveModel::Attribute::FromUser
   1966751  Regexp
   1529136  Thread::Backtrace
   1528736  Time
   1298208  ActiveSupport::Notifications::Event
   1293560  Arel::Attributes::Attribute
   1283400  Arel::Nodes::BindParam
    972288  ActiveRecord::Result
    921128  Arel::Nodes::SelectCore
    867600  Service
    779416  Arel::Nodes::SelectStatement
    720992  ActiveModel::LazyAttributeHash
    708160  ActiveModel::Attribute::WithCastValue
    684600  ActiveModel::AttributeSet
    656016  ActiveRecord::AssociationRelation
    624000  ActiveRecord::Relation::WhereClauseFactory
    606880  ActiveSupport::Callbacks::Filters::Environment
    585744  ActiveRecord::Associations::BelongsToAssociation
    572960  ActiveRecord::Relation::Merger
    524880  Arel::Collectors::Bind
    524880  Arel::Collectors::Composite
    524880  Arel::Collectors::SQLString
    466360  Arel::Nodes::Equality
    463232  HABTM_Services
    396680  Set
    396640  ActiveModel::AttributeMutationTracker
    354280  Arel::Nodes::JoinSource
    354280  Arel::Nodes::SqlLiteral
    354280  Arel::SelectManager
    354120  Arel::Nodes::And
    354080  Arel::Nodes::Limit
    354080  Arel::Nodes::Top
    307088  Arel::Nodes::InsertStatement
    290960  ActiveModel::Errors
    240488  City
    191704  Bus
    176000  Trip

allocated objects by gem
-----------------------------------
   2187313  activerecord-5.2.3
    576369  activesupport-5.2.3
    386334  activemodel-5.2.3
    324041  arel-9.0.0
     67832  i18n-1.6.0
     21232  json
     17466  rails-optimization-task3/lib
     13511  logger
      9922  set
      2704  bootsnap-1.4.2
        92  concurrent-ruby-1.1.5
        91  rails-optimization-task3/app
        13  rake-12.3.2
         7  monitor
         7  mutex_m
         7  railties-5.2.3
         3  other

allocated objects by file
-----------------------------------
    263001  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb
    209177  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb
    195606  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb
    177022  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/where_clause.rb
    162249  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/query_methods.rb
    136835  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb
    114236  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb
    110067  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb
    101607  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb
     89263  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb
     72646  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb
     66041  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract_adapter.rb
     55052  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/merger.rb
     54739  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/persistence.rb
     54092  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/subscriber.rb
     53142  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/nodes/select_core.rb
     52925  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/querying.rb
     50813  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/collection_association.rb
     50236  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/database_statements.rb
     48985  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/to_sql.rb
     47632  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb
     44508  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/quoting.rb
     43280  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql_adapter.rb
     43098  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/spawn_methods.rb
     42146  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/core.rb
     39657  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/result.rb
     39443  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_set.rb
     37041  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/select_manager.rb
     36555  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_set/builder.rb
     35754  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb
     35700  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/table.rb
     33333  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb
     32846  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/association.rb
     31974  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/where_clause_factory.rb
     31508  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb
     30972  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/hash_with_indifferent_access.rb
     30602  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/postgresql.rb
     29576  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb
     27046  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/notifications/instrumenter.rb
     27022  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/log_subscriber.rb
     27022  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/tagged_logging.rb
     26571  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/nodes/select_statement.rb
     26386  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/backend/base.rb
     26320  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/has_many_through_association.rb
     25977  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/timestamp.rb
     24520  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/interpolate/ruby.rb
     22244  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/association_scope.rb
     21232  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/json/common.rb
     21047  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/object/deep_dup.rb
     20676  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb

allocated objects by location
-----------------------------------
    106468  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
     85004  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:35
     78375  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
     72646  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107
     71166  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:806
     57296  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/where_clause.rb:25
     52865  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:404
     52865  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:425
     48046  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:89
     40569  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/subscriber.rb:100
     40550  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:198
     36848  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/collection_association.rb:481
     35624  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:83
     33950  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:132
     32339  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/table.rb:81
     31974  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/where_clause.rb:13
     30988  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/quoting.rb:161
     30988  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:58
     30602  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/postgresql.rb:49
     29542  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb:9
     29307  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:29
     28648  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/where_clause.rb:109
     27022  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/log_subscriber.rb:109
     27022  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/tagged_logging.rb:23
     26244  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract_adapter.rb:612
     25870  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_set.rb:37
     25426  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb:13
     25426  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb:71
     25079  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:103
     24664  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:25
     24520  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/interpolate/ruby.rb:23
     23848  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/result.rb:128
     23446  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:17
     23233  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb:60
     23233  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb:61
     22137  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql_adapter.rb:447
     21460  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:424
     21231  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/json/common.rb:156
     21058  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:180
     21058  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:189
     21058  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:191
     20529  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:279
     20072  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb:71
     19012  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/core.rb:285
     18967  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:508
     18095  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/to_sql.rb:820
     17714  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/nodes/select_statement.rb:8
     16775  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/object/deep_dup.rb:16
     16472  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/to_sql.rb:729
     16329  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:46

allocated objects by class
-----------------------------------
   1564289  Array
    813953  String
    470569  Hash
     80868  Proc
     61009  ActiveRecord::Relation::WhereClause
     46334  ActiveModel::Attribute::FromDatabase
     39133  ActiveRecord::Relation
     32339  Arel::Attributes::Attribute
     32085  Arel::Nodes::BindParam
     25426  ActiveModel::Attribute::FromUser
     23620  ActiveRecord::Relation::QueryAttribute
     22176  Enumerator
     17776  Time
     17115  ActiveModel::AttributeSet
     16173  MatchData
     15600  ActiveRecord::Relation::WhereClauseFactory
     15172  ActiveSupport::Callbacks::Filters::Environment
     14324  ActiveRecord::Relation::Merger
     13527  PG::Result
     13523  ActiveSupport::Notifications::Event
     13504  ActiveRecord::Result
     13122  Arel::Collectors::Bind
     13122  Arel::Collectors::Composite
     13122  Arel::Collectors::SQLString
     12623  Class
     12548  ActiveSupport::HashWithIndifferentAccess
     11659  Arel::Nodes::Equality
      9917  Set
      9916  ActiveModel::AttributeMutationTracker
      8857  Arel::Nodes::JoinSource
      8857  Arel::Nodes::SelectCore
      8857  Arel::Nodes::SelectStatement
      8857  Arel::Nodes::SqlLiteral
      8857  Arel::SelectManager
      8853  Arel::Nodes::And
      8852  ActiveModel::Attribute::WithCastValue
      8852  Arel::Nodes::Limit
      8852  Arel::Nodes::Top
      8193  ActiveModel::LazyAttributeHash
      7274  ActiveModel::Errors
      5826  Service
      5652  ActiveRecord::AssociationRelation
      5632  ActiveRecord::Associations::BelongsToAssociation
      4265  Arel::InsertManager
      4265  Arel::Nodes::InsertStatement
      4265  Arel::Nodes::Values
      3361  Arel::Table
      2632  HABTM_Services
      2461  Regexp
      2452  I18n::MissingTranslation

retained memory by gem
-----------------------------------
    143695  activerecord-5.2.3
     75262  activesupport-5.2.3
     30376  rails-optimization-task3/app
     24952  bootsnap-1.4.2
     17577  i18n-1.6.0
     15687  activemodel-5.2.3
     14456  concurrent-ruby-1.1.5
      1104  arel-9.0.0
       868  set
       504  monitor
       504  mutex_m
       175  railties-5.2.3
        40  other

retained memory by file
-----------------------------------
     37936  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb
     30568  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb
     15714  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb
     14934  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb
     14869  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/core_ext/hash.rb
     14033  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb
     11216  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/concurrent-ruby-1.1.5/lib/concurrent/collection/map/non_concurrent_map_backend.rb
      9463  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb
      9360  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/redefine_method.rb
      8704  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/core.rb
      8328  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/bus.rb
      8097  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb
      8096  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/service.rb
      7424  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/array/extract_options.rb
      7192  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/except.rb
      6963  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb
      6480  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/trip.rb
      5210  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/statement_cache.rb
      5012  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb
      4872  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/city.rb
      4624  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/schema_statements.rb
      4604  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/join_dependency.rb
      4528  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb
      3936  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb
      3584  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_decorators.rb
      3440  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb
      3375  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/loaded_features_index.rb
      3312  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/legacy_yaml_adapter.rb
      3240  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/concurrent-ruby-1.1.5/lib/concurrent/collection/map/mri_map_backend.rb
      2768  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb
      2600  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/application_record.rb
      2568  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/association_scope.rb
      2024  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations.rb
      1983  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb
      1966  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/has_many_through_association.rb
      1952  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb
      1848  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb
      1656  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/belongs_to.rb
      1624  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/object/deep_dup.rb
      1502  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/has_many_association.rb
      1440  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/schema_cache.rb
      1390  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/alias_tracker.rb
      1360  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n.rb
      1344  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb
      1339  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/dynamic_matchers.rb
      1310  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/belongs_to_association.rb
      1270  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/read.rb
      1265  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql_adapter.rb
      1226  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/delegation.rb
      1174  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/join_dependency/join_part.rb

retained memory by location
-----------------------------------
     22168  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:17
     14033  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
     13600  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:47
     11136  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/concurrent-ruby-1.1.5/lib/concurrent/collection/map/non_concurrent_map_backend.rb:16
     11136  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/core_ext/hash.rb:15
      9360  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/redefine_method.rb:29
      8904  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:49
      8719  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
      7424  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/array/extract_options.rb:30
      7264  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/bus.rb:1
      7264  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/service.rb:1
      7192  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/except.rb:13
      6963  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28
      5720  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/core.rb:226
      5568  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:841
      5344  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/trip.rb:1
      4832  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/city.rb:1
      4512  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:289
      4240  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:424
      3375  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/loaded_features_index.rb:109
      3360  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:42
      3240  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/concurrent-ruby-1.1.5/lib/concurrent/collection/map/mri_map_backend.rb:14
      3024  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:462
      2800  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:450
      2786  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:104
      2786  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:99
      2720  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:153
      2600  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/application_record.rb:1
      2480  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:483
      2184  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/core.rb:148
      2053  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/core_ext/hash.rb:30
      2016  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:464
      1983  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
      1904  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_decorators.rb:67
      1904  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/schema_statements.rb:653
      1886  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/join_dependency.rb:261
      1880  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:302
      1680  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_decorators.rb:45
      1656  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:31
      1624  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations.rb:278
      1624  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:11
      1624  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/object/deep_dup.rb:44
      1566  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/association_scope.rb:167
      1560  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/statement_cache.rb:121
      1536  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/belongs_to.rb:163
      1512  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:82
      1502  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/has_many_association.rb:143
      1502  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/has_many_through_association.rb:226
      1464  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:22
      1456  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:559

retained memory by class
-----------------------------------
     85928  Class
     66231  String
     61480  Hash
     26400  Proc
     21064  Array
     13600  ActiveRecord::AttributeMethods::GeneratedAttributeMethods
     13456  Module
      6840  Thread::Mutex
      4512  ActiveSupport::Callbacks::Callback
      3816  ActiveSupport::Callbacks::CallTemplate
      2521  Regexp
      2080  Symbol
      1904  ActiveRecord::ConnectionAdapters::PostgreSQLColumn
      1800  Concurrent::Map
      1360  ActiveRecord::ConnectionAdapters::PostgreSQLTypeMetadata
      1360  ActiveRecord::ConnectionAdapters::SqlTypeMetadata
      1344  ActiveModel::Attribute::FromDatabase
      1200  ActiveSupport::Callbacks::CallbackChain
      1040  ActiveSupport::Callbacks::CallbackSequence
       936  ActiveRecord::Reflection::BelongsToReflection
       720  ActiveRecord::Reflection::HasManyReflection
       504  Monitor
       480  ActiveSupport::Callbacks::Conditionals::Value
       440  ActiveRecord::Validations::PresenceValidator
       400  ActiveRecord::PredicateBuilder::ArrayHandler
       280  ActiveRecord::AttributeDecorators::TypeDecorator
       240  ActiveRecord::Reflection::HasAndBelongsToManyReflection
       200  ActiveModel::AttributeSet
       200  ActiveRecord::PredicateBuilder
       200  ActiveRecord::PredicateBuilder::BaseHandler
       200  ActiveRecord::PredicateBuilder::BasicObjectHandler
       200  ActiveRecord::PredicateBuilder::RangeHandler
       200  ActiveRecord::PredicateBuilder::RelationHandler
       200  ActiveRecord::TableMetadata
       200  ActiveRecord::TypeCaster::Map
       200  Arel::Table
       160  ActiveModel::AttributeMethods::ClassMethods::AttributeMethodMatcher::AttributeMethodMatch
       144  ActiveModel::Name
       120  ActiveModel::AttributeSet::Builder
       120  ActiveModel::AttributeSet::YAMLEncoder
       120  ActiveRecord::Reflection::ThroughReflection
        80  ActiveModel::Validations::InclusionValidator
        80  ActiveModel::Validations::NumericalityValidator
        80  ActiveRecord::Associations::Builder::HasAndBelongsToMany::JoinTableResolver::KnownTable
        80  ActiveRecord::Relation::QueryAttribute
        80  ActiveRecord::Validations::UniquenessValidator
        40  ActiveModel::Validations::FormatValidator
        40  ActiveRecord::Associations::AssociationScope
        40  ActiveRecord::ConnectionAdapters::TransactionState
        40  ActiveRecord::Reflection::AbstractReflection::JoinKeys

retained objects by gem
-----------------------------------
       922  activerecord-5.2.3
       813  activesupport-5.2.3
       419  bootsnap-1.4.2
       287  activemodel-5.2.3
       122  i18n-1.6.0
        92  concurrent-ruby-1.1.5
        54  rails-optimization-task3/app
        16  arel-9.0.0
         7  monitor
         7  mutex_m
         6  set
         1  other
         1  railties-5.2.3

retained objects by file
-----------------------------------
       461  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb
       250  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb
       191  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb
       143  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb
       120  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb
       117  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/redefine_method.rb
       102  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/core_ext/hash.rb
        97  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb
        76  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb
        70  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb
        66  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb
        57  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb
        53  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/core.rb
        51  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/schema_statements.rb
        47  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/concurrent-ruby-1.1.5/lib/concurrent/collection/map/non_concurrent_map_backend.rb
        45  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb
        45  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/concurrent-ruby-1.1.5/lib/concurrent/collection/map/mri_map_backend.rb
        42  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_decorators.rb
        42  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb
        36  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb
        34  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb
        32  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/array/extract_options.rb
        31  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/except.rb
        24  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/callbacks.rb
        22  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb
        22  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb
        21  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/statement_cache.rb
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/read.rb
        19  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/loaded_features_index.rb
        18  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations/with.rb
        17  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb
        17  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations.rb
        17  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/bus.rb
        16  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/write.rb
        16  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/service.rb
        16  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/trip.rb
        15  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/time_zone_conversion.rb
        14  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/quoting.rb
        14  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n.rb
        13  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql_adapter.rb
        13  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/visitor.rb
        12  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/schema_cache.rb
        11  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/join_dependency.rb
        11  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/inheritance.rb
        11  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/delegation.rb
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb
         9  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/association_scope.rb
         9  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/legacy_yaml_adapter.rb
         8  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/type/type_map.rb

retained objects by location
-----------------------------------
       250  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
       174  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
       143  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28
       117  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/redefine_method.rb:29
        53  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:424
        50  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:450
        50  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/core_ext/hash.rb:30
        47  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:289
        47  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:302
        45  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
        45  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/concurrent-ruby-1.1.5/lib/concurrent/collection/map/mri_map_backend.rb:14
        45  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/concurrent-ruby-1.1.5/lib/concurrent/collection/map/non_concurrent_map_backend.rb:16
        45  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/core_ext/hash.rb:15
        42  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:17
        40  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:104
        40  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:99
        36  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:464
        35  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:301
        34  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:153
        32  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/array/extract_options.rb:30
        31  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:483
        31  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/except.rb:13
        30  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb:47
        28  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_decorators.rb:45
        24  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
        21  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/core.rb:148
        21  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:82
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:35
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:36
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/read.rb:36
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:181
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:452
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:101
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:96
        19  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/loaded_features_index.rb:109
        18  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations/with.rb:86
        18  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:462
        17  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute.rb:87
        17  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/schema_statements.rb:653
        17  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/schema_statements.rb:668
        17  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/schema_statements.rb:675
        17  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400
        15  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:22
        15  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:559
        15  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:560
        15  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:627
        14  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_decorators.rb:67
        14  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/quoting.rb:47
        14  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:433

retained objects by class
-----------------------------------
      1109  String
       419  Array
       330  Proc
       235  Hash
        95  Class
        95  Thread::Mutex
        53  ActiveSupport::Callbacks::CallTemplate
        52  Symbol
        47  ActiveSupport::Callbacks::Callback
        45  Concurrent::Map
        22  Module
        17  ActiveModel::Attribute::FromDatabase
        17  ActiveRecord::ConnectionAdapters::PostgreSQLColumn
        17  ActiveRecord::ConnectionAdapters::PostgreSQLTypeMetadata
        17  ActiveRecord::ConnectionAdapters::SqlTypeMetadata
        15  ActiveSupport::Callbacks::CallbackChain
        13  ActiveSupport::Callbacks::CallbackSequence
        12  ActiveSupport::Callbacks::Conditionals::Value
        11  ActiveRecord::Validations::PresenceValidator
        10  ActiveRecord::PredicateBuilder::ArrayHandler
         7  ActiveRecord::AttributeDecorators::TypeDecorator
         7  ActiveRecord::AttributeMethods::GeneratedAttributeMethods
         7  ActiveRecord::Reflection::BelongsToReflection
         7  Monitor
         5  ActiveModel::AttributeSet
         5  ActiveRecord::PredicateBuilder
         5  ActiveRecord::PredicateBuilder::BaseHandler
         5  ActiveRecord::PredicateBuilder::BasicObjectHandler
         5  ActiveRecord::PredicateBuilder::RangeHandler
         5  ActiveRecord::PredicateBuilder::RelationHandler
         5  ActiveRecord::Reflection::HasManyReflection
         5  ActiveRecord::TableMetadata
         5  ActiveRecord::TypeCaster::Map
         5  Arel::Table
         4  ActiveModel::AttributeMethods::ClassMethods::AttributeMethodMatcher::AttributeMethodMatch
         4  Regexp
         3  ActiveModel::AttributeSet::Builder
         3  ActiveModel::AttributeSet::YAMLEncoder
         2  ActiveModel::Validations::InclusionValidator
         2  ActiveModel::Validations::NumericalityValidator
         2  ActiveRecord::Associations::Builder::HasAndBelongsToMany::JoinTableResolver::KnownTable
         2  ActiveRecord::Reflection::HasAndBelongsToManyReflection
         2  ActiveRecord::Reflection::ThroughReflection
         2  ActiveRecord::Validations::UniquenessValidator
         1  ActiveModel::Name
         1  ActiveModel::Validations::FormatValidator
         1  ActiveRecord::Associations::AssociationScope
         1  ActiveRecord::ConnectionAdapters::TransactionState
         1  ActiveRecord::Reflection::AbstractReflection::JoinKeys
         1  ActiveRecord::Relation::QueryAttribute

Allocated String Report
-----------------------------------
     44985  "buses_services"
     36131  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
      5264  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/collection_association.rb:481
      2632  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/has_many_through_association.rb:76
       937  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:405
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:99
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:28
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb:1840
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:181
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:212
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/schema_cache.rb:114
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:352
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:37
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400

     34687  "name"
      6616  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:83
      6616  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/result.rb:128
      6239  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:219
      6229  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb:29
      6229  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:46
      2662  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
        32  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:40
        14  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/validations/uniqueness.rb:102
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/validations/uniqueness.rb:73
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:406
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:96
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:97
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/quoting.rb:68

     28157  "id"
     11881  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:83
      8193  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_set/builder.rb:115
      7616  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/result.rb:128
       387  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/validations/uniqueness.rb:26
        60  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:406
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/quoting.rb:47

     27009  "service"
     24348  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
      2632  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/has_many_through_association.rb:61
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:405
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:72
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:94
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:107
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:108
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:115
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:116
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:98
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:19
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:20
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:28
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:33
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:36
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:37
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:181
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:212
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:352
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:37
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:655
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:662

     24862  "1"
     15501  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107
      9356  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/json/common.rb:156
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/type/string.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:89

     19650  ""
     13511  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/tagged_logging.rb:23
      3361  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/table.rb:22
      1842  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:141
       614  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:140
       252  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:375
        12  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/read.rb:38
        12  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/write.rb:23
         7  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:43
         7  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/loaded_features_index.rb:98
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/loaded_features_index.rb:101
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/inheritance.rb:185
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/inheritance.rb:190
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb:513
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/cache.rb:65
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:28
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/schema_statements.rb:768
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/dynamic_matchers.rb:38
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n.rb:378

     16968  "Service"
      7657  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:85
      4616  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/querying.rb:41
      4616  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/querying.rb:48
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/persistence.rb:187
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:94
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:81
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/suppressor.rb:44
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:72
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/inheritance.rb:190
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:409
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:487
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:273
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:328
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:112
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:98
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/primary_key.rb:87
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb:513
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/introspection.rb:13
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

     16633  "Bus"
      4452  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:94
      2227  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:85
      2226  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:81
      1613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/suppressor.rb:44
      1612  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:97
      1226  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/persistence.rb:187
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/querying.rb:41
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/querying.rb:48
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/backend/base.rb:48
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/interpolate/ruby.rb:23
         8  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/inheritance.rb:185
         8  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:273
         6  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:328
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:494
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:487
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:72
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/inheritance.rb:190
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:409
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/anonymous.rb:28
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:680
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/naming.rb:149
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:112
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:98
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/primary_key.rb:87
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb:513
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:612
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:666
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:114
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/introspection.rb:13
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:130
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

     15549  "2"
     15113  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107
       428  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/json/common.rb:156
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/type/string.rb:18
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:89

     14701  "number"
      3226  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
      2613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:219
      1613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/validations/uniqueness.rb:102
      1613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/validations/uniqueness.rb:73
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/json/common.rb:156
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:83
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/predicate_builder.rb:29
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/result.rb:128
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:46
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:40
        16  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:406
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/quoting.rb:68
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28

     13525  "sql"
     13523  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/subscriber.rb:100
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

     13523  "active_record"
     13523  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/subscriber.rb:100

     13118  "$1"
     13118  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/postgresql.rb:49

     13097  "$2"
     13097  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/postgresql.rb:49

     11998  "model"
      3065  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:140
      1839  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:141
      1226  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/translation.rb:46
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/json/common.rb:156
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:83
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/result.rb:128
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:40
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:407
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:415
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:145
        16  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
         6  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n.rb:378
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:406
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24

      9808  "(?-mix:%%)|(?-mix:%\\{(\\w+)\\})|(?-mix:%<(\\w+)>(.*?\\d*\\.?\\d*[bBdiouxXeEfgGcps]))"
      9808  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/interpolate/ruby.rb:23

      9239  "services"
      5264  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/collection_association.rb:481
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/json/common.rb:156
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:40
       936  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:282
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:405
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:352
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:72
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb:1841
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb:1856
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:107
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:108
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:115
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:116
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:54
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:55
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:64
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:65
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:72
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:88
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:99
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:181
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:212
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/schema_cache.rb:114
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb:513
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:37

      8852  "\"LIMIT\""
      8852  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37

      8852  "[\"LIMIT\", 1]"
      8852  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37

      7352  "0.2"
      7352  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107

      7020  "duration_minutes"
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/json/common.rb:156
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:382
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations/numericality.rb:128
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations/numericality.rb:26
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/before_type_cast.rb:49
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:40
        16  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:406
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

      7020  "price_cents"
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/json/common.rb:156
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:382
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations/numericality.rb:128
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations/numericality.rb:26
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/before_type_cast.rb:49
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:40
        16  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:406
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

      6916  "bus"
      3002  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/json/common.rb:156
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:40
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:407
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:408
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/translation.rb:58
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:405
         8  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:94
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:140
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n.rb:378
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:141
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:107
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:108
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:115
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:116
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:19
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:20
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:28
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:29
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:32
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:33
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:36
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:37
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:181
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:212
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:352
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:37
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:72
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/naming.rb:196
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:98
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:655
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:662
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:145
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

      6313  "\"name\""
      6259  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
        32  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:372
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/to_sql.rb:128
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/quoting.rb:47

      6139  "City"
      2021  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:85
      2000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/querying.rb:41
      2000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/querying.rb:48
        40  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:94
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/persistence.rb:187
        20  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:81
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/suppressor.rb:44
         9  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:97
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/inheritance.rb:190
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:409
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:487
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:273
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:328
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/primary_key.rb:87
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb:513
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation/delegation.rb:114
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/introspection.rb:13
         1  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/trip.rb:4
         1  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/trip.rb:5

      6009  "empty?"
      6000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:454
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:400
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:401

      5562  "0.1"
      5562  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107

      5275  "bus_id="
      2632  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_assignment.rb:49
      2632  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:279
         6  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/write.rb:26
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/write.rb:20
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:406

      5270  "after_add"
      5264  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/collection_association.rb:481
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

      5270  "before_add"
      5264  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/collection_association.rb:481
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

      5268  "Bus::HABTM_Services"
      5264  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/persistence.rb:187
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/inheritance.rb:190
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb:1828
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:112

      5264  "to_ary"
      5264  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:279

      5021  "to"
      3000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/json/common.rb:156
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:40
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:107
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:108
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:115
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:116
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:19
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:20
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:28
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:33
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:36
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:37
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:181
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:212
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:352
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:37
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:662
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:405

      5019  "from"
      3000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:116
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/json/common.rb:156
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/hash/keys.rb:40
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:107
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:108
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:115
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/association.rb:116
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:19
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:20
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:28
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:33
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:36
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/singular_association.rb:37
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:181
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:212
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:352
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:37
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:662
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:405
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

      4616  "Service Load"
      4616  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/querying.rb:41

      4242  "3"
      3752  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107
       485  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/json/common.rb:156
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/type/string.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:89

      4230  "\"services\".*"
      4230  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/to_sql.rb:729

      4229  "\e[1m\e[34mSELECT  \"services\".* FROM \"services\" WHERE \"services\".\"name\" = $1 LIMIT $2\e[0m"
      4229  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/log_subscriber.rb:109

      4229  "\"$user\", public-SELECT  \"services\".* FROM \"services\" WHERE \"services\".\"name\" = $1 LIMIT $2"
      4229  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql_adapter.rb:666

      4229  "\"services\".\"name\""
      4229  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/to_sql.rb:729

      4229  "SELECT  \"services\".* FROM \"services\" WHERE \"services\".\"name\" = $1 LIMIT $2"
      4229  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/collectors/plain_string.rb:6

      4052  "\"bus_id\""
      4019  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
        32  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:372
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/quoting.rb:47

      4033  "Trip"
      2000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/persistence.rb:187
      1001  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/scoping.rb:85
      1000  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/suppressor.rb:48
         8  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/inheritance.rb:185
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:494
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:273
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:612
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/relation.rb:409
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/anonymous.rb:28
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:680
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:328
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/primary_key.rb:87
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb:513
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/module/introspection.rb:13
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:487
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

      3803  "4"
      3311  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107
       487  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/json/common.rb:156
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/type/string.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:89

      3791  "6"
      3302  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107
       489  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37

      3759  "5"
      3280  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/numeric/conversions.rb:107
       471  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/json/common.rb:156
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/type/string.rb:18
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:89

      3692  "inclusion"
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:407
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:408
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:410
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:415
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/errors.rb:416
       613  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n/backend/simple.rb:98
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/i18n-1.6.0/lib/i18n.rb:378
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:72
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/validations/validates.rb:116
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28

      3502  "\e[1m\e[36mService Load (0.1ms)\e[0m"
      3502  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/log_subscriber.rb:109

      3502  "Service Load (0.1ms)"
      3502  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:28

      3244  "\"number\""
      3226  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/log_subscriber.rb:37
        16  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:372
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/quoting.rb:47

Retained String Report
-----------------------------------
        18  "validate"
        18  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:462

        11  "id"
        10  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/quoting.rb:47

        10  "buses"
         6  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/naming.rb:163
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/schema_cache.rb:114
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb:513
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

         7  "bus_id"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/time_zone_conversion.rb:84
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:662
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:252

         7  "integer"
         7  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24

         5  "bigint"
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24

         5  "buses_services"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:28
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/schema_cache.rb:114
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

         5  "character varying"
         5  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24

         5  "from_id"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/time_zone_conversion.rb:84
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:662

         5  "service_id"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/time_zone_conversion.rb:84
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:662

         5  "services"
         3  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/schema_cache.rb:114
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb:513

         5  "to_id"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:380
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods/time_zone_conversion.rb:84
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/reflection.rb:662

         4  ""
         4  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28

         4  "empty?"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:401
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/attribute_methods.rb:454

         4  "trips"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/schema_cache.rb:114
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/model_schema.rb:513
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18

         3  "\"name\""
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/quoting.rb:47
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/visitors/to_sql.rb:128

         3  "Bus"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/naming.rb:149
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:130
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:72

         3  "City"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/trip.rb:4
         1  /home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/trip.rb:5

         3  "bus"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activemodel-5.2.3/lib/active_model/naming.rb:196
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:400
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/inflector/methods.rb:94

         3  "name"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/database_statements.rb:24
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29

         2  "\"number\""
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/postgresql/quoting.rb:47

         2  "%n %u"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28

         2  ","
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28

         2  "."
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/application_record"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/set.rb:349
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:353

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/application_record.rb"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:22

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/bus"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/set.rb:349
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:353

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/bus.rb"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:22

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/city"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/set.rb:349
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:353

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/city.rb"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:22

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/service"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/set.rb:349
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:353

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/service.rb"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:22

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/trip"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/2.6.0/set.rb:349
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/dependencies.rb:353

         2  "/home/theendcomplete/Documents/projects/my/rails-optimization-task3/app/models/trip.rb"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/iseq.rb:18
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:22

         2  "ATTR_0727963656f53656e64737"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29

         2  "ATTR_3747162747f54796d656"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29

         2  "ATTR_37562767963656f59646"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29

         2  "ATTR_465727164796f6e6f5d696e657475637"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/attribute_methods.rb:29

         2  "Bus::HABTM_Services"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb:1828
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:112

         2  "HABTM_Buses"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb:1828
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:88

         2  "HABTM_Services"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb:1828
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:88

         2  "May"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28

         2  "SELECT \"services\".* FROM \"services\" INNER JOIN \"buses_services\" ON \"services\".\"id\" = \"buses_services\".\"service_id\" WHERE \"buses_services\".\"bus_id\" = $1"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/connection_adapters/abstract/database_statements.rb:39
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/arel-9.0.0/lib/arel/collectors/plain_string.rb:6

         2  "Service::HABTM_Buses"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations.rb:1828
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/has_and_belongs_to_many.rb:112

         2  "Validation failed: %{errors}"
         2  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.4.2/lib/bootsnap/compile_cache/yaml.rb:28

         2  "after_add_for_buses"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:96

         2  "after_add_for_buses_services"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:96

         2  "after_add_for_services"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:96

         2  "after_add_for_services_buses"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:96

         2  "after_add_for_trips"
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.3/lib/active_record/associations/builder/collection_association.rb:32
         1  /home/theendcomplete/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:96

.

Finished in 25.82 seconds (files took 1.09 seconds to load)
1 example, 0 failures
```

Подключил PgHero:

![case-study/Untitled%201.png](case-study/Untitled%201.png)

После добавления индекса время загрузки `small` файла сократилось до 6 секунд:

```bash
Finished in 7.16 seconds (files took 1.18 seconds to load)
1 example, 0 failures
```

```ruby
class AddIndexToBusesOnNumber < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :buses, :number, algorithm: :concurrently
  end
end
```

Обратил внимание на показания New Relic:

![case-study/Untitled%202.png](case-study/Untitled%202.png)

Где-то здесь я осознал, что мой фидбэк-луп перестал меня устраивать. Я вывел код рейк-таска импорта в сервис импорта и вызываемый из рейк-таска таким образом: 
`ReimportDatabaseService.new(file_name: args.file_name).call`. Этот рефакторинг значительно облегчил тестирование сервиса при изменениях.

Пересмотрел лекции, обратил внимание на постоянный вызов `find_or_create` в скрипте импорта.

Решил попробовать "кэшировать" идентификаторы  по образу задания 2:

```ruby
def reload_json
    json = Oj.load(File.read(file_name))

    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("delete from cities;
                                             delete from buses;
                                             delete from services;
                                             delete from trips;
                                             delete from buses_services;")
      all_services = []
      Service::SERVICES.each do |service|
        s = Service.new(name: service)
        all_services << s
      end
      Service.import(all_services)
      trips = []
      cities = {}
      buses = []

      json.each do |trip|
        from = cities[trip["from"]] || City.create(name: trip["from"])
        cities[trip["from"]] = from.id if cities[trip["from"]].blank?
        to = cities[trip["to"]] || City.create(name: trip["to"])
        cities[trip["to"]] = to.id if cities[trip["to"]].blank?

        services = []
        bus = Bus.find_or_create_by(model: trip["bus"]["model"], number: trip["bus"]["number"])
        bus.services << Service.where(name: trip["bus"]["services"])

        trips << Trip.new(
          from_id: cities[trip["from"]],
          to_id: cities[trip["from"]],
          bus: bus,
          start_time: trip["start_time"],
          duration_minutes: trip["duration_minutes"],
          price_cents: trip["price_cents"]
        )
      end
      Trip.import(trips)
    end
```

Время обработки маленького файла сократилось до 9 секунд:

```bash
(base) theendcomplete@N10L:~/Documents/projects/my/rails-optimization-task3$ bundle exec rspec spec/benchmarks/reload_json_cpu_benchmark.rb
finished  in 8.821296841000049
.

Finished in 8.87 seconds (files took 1.03 seconds to load)
```

продолжил кэшировать другие объекты, сверяясь с rspec'ом. сократил скорость загрузки `small` файла до 1,15 секунд:

```ruby
def reload_json
    json = Oj.load(File.read(file_name))

    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("delete from cities;
                                             delete from buses;
                                             delete from services;
                                             delete from trips;
                                             delete from buses_services;")
      all_services = []
      Service::SERVICES.each do |service|
        s = Service.new(name: service)
        all_services << s
      end
      Service.import(all_services)
      service_cache = {}
      Service.select(:name, :id).map do |s|
        service_cache[s.attributes['name']] = s.attributes['id']
      end
      trips = []
      cities = {}
      buses = []
      buses_services = []
      buses_cache = {}
      json.each do |trip|
        from = cities[trip['from']] || City.create(name: trip['from'])
        cities[trip['from']] = from.id if cities[trip['from']].blank?
        to = cities[trip['to']] || City.create(name: trip['to'])
        cities[trip['to']] = to.id if cities[trip['to']].blank?

        services = []
        bus_id = if buses_cache["#{trip['bus']['model']} #{trip['bus']['number']}"]
                   buses_cache["#{trip['bus']['model']} #{trip['bus']['number']}"]
                 else
                   b = Bus.create(model: trip['bus']['model'], number: trip['bus']['number'])
                   buses_cache["#{trip['bus']['model']} #{trip['bus']['number']}"] = b.id
                   b.id
                 end

        trip['bus']['services'].each do |serv|
          buses_services << { bus_id: bus_id, service_id: service_cache[serv].to_i }
        end

        trips << Trip.new(
          from_id: cities[trip['from']],
          to_id: cities[trip['from']],
          bus_id: bus_id,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents']
        )
      end
      BusService.import(buses_services)
      Trip.import(trips)
    end
  end

```

```bash
(base) theendcomplete@N10L:~/Documents/projects/my/rails-optimization-task3$ bundle exec rspec spec/benchmarks/reload_json_cpu_benchmark.rb
finished  in 1.1588479160000134
.

Finished in 1.21 seconds (files took 1.05 seconds to load)
1 example, 0 failures
```

Скорость загрузки большого файла сократилась до 61 секунды, что практически укладывается в бюджет:

```ruby
bundle exec rspec spec/benchmarks/reload_json_cpu_benchmark.rb
finished  in 61.281657451
```

тем не менее, результат требуется закрепить.

Дополнил спеки тестированием вывода TripController, скорректировал загрузку BusService:

```ruby
(base) theendcomplete@N10L:~/Documents/projects/my/rails-optimization-task3$ bundle exec rspec spec/benchmarks/reload_json_performance_spec.rb
.

Finished in 24.12 seconds (files took 1.03 seconds to load)
1 example, 0 failures
```

24 секунды вполне в рамках бюджета, переходим ко второй части задания:

Ругань `bullet` при открытии страницы:

![case-study/Untitled%203.png](case-study/Untitled%203.png)

`rack-mini-profiler`:

![case-study/Untitled%204.png](case-study/Untitled%204.png)

Добавил scope with_bus и использовал в контроллере:

![case-study/Untitled%205.png](case-study/Untitled%205.png)

![case-study/Untitled%206.png](case-study/Untitled%206.png)

Время загрузки страмицы с 900 поездками ~18 секунд.

Самая медленная часть - рендеринг Rendering: `trips/_services.html.erb`

Избавление от лишнего partial'a сократило время рендеринга на треть, до 12 секунд:

![case-study/Untitled%207.png](case-study/Untitled%207.png)

Во время оптимизации регулярно смотрю на показания pgHero и New relic, следуя их советам:

![case-study/Untitled%208.png](case-study/Untitled%208.png)

Вместо того, чтобы переписывать весь  код отображения, задумался над тем, чтобы кэшировать partial'ы. 

В качестве эксперимента попробовал Kaminari, это улучшило user experience без рефакторинга вьюх, однако общее время просмотра всех маршрутов, конечно, при пагинации станет выше.
