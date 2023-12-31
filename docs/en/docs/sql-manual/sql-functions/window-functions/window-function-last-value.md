---
{
    "title": "WINDOW_FUNCTION_LAST_VALUE",
    "language": "en"
}
---

<!--  Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements.  See the NOTICE file distributed with this work for additional information regarding copyright ownership.  The ASF licenses this file to you under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the specific language governing permissions and limitations under the License. -->

## WINDOW FUNCTION LAST_VALUE
### description

LAST_VALUE() returns the last value in the window range. Opposite of FIRST_VALUE() .

```sql
LAST_VALUE(expr) OVER(partition_by_clause order_by_clause [window_clause])
```

### example

Using the data from the FIRST_VALUE() example:

```sql
select country, name,    
last_value(greeting)   
over (partition by country order by name, greeting) as greeting   
from mail_merge;

| country | name    | greeting     |
|---------|---------|--------------|
| Germany | Boris   | Guten morgen |
| Germany | Michael | Guten morgen |
| Sweden  | Bjorn   | Tja          |
| Sweden  | Mats    | Tja          |
| USA     | John    | Hello        |
| USA     | Pete    | Hello        |
```

### keywords

    WINDOW,FUNCTION,LAST_VALUE
