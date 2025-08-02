{% prql %}

let source = {{ref('FactOnlineSales')}}
from source
select source.*



{% endprql %}


