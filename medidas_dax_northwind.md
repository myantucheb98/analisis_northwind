--- TB_ORDERS
--- Ventas Promedio ---

Ventas Promedio por Pedido = 
DIVIDE([Ventas Reales], DISTINCTCOUNT('Orders'[OrderID]))

--- Crecimiento % año con año --- 

% Crecimiento YoY = 
VAR VentasActual = [Ventas Reales]
VAR VentasAnterior = 
CALCULATE(
    [Ventas Reales],
    SAMEPERIODLASTYEAR(Calendario[Date])
)
RETURN
IF(
    ISBLANK(VentasAnterior) || VentasAnterior = 0,
    BLANK(),
    DIVIDE(VentasActual - VentasAnterior, VentasAnterior)
    )

--- TB_EMPLEADOS
--- TOP EMPLEADOS
TOP VENDEDORES = 
VAR TopVendedor = 
TOPN(
    1,
    ALL(Employees[FirstName]),
    [Ventas Reales],
    DESC
)
RETURN
    CONCATENATEX(
        TopVendedor,
        Employees[FirstName] & " - " & FORMAT([Ventas Reales], "$#,##OK"),
        ", "
    )

--- Cantidad de Ventdedores
Cantidad Vendedores = 
DISTINCTCOUNT(Employees[EmployeeID])

--- TB_CLIENTES
--- VENTAS promedio x cliente
Ventas Promedio por Cliente = 
DIVIDE([Ventas Reales], DISTINCTCOUNT(Customers[CustomerID]))

--- Cantidad Clientes
Cantidad Clientes = COUNT(Customers[CustomerID])

--- TB_CATEGORIAS
--- ventas ytd
Ventas YTD = 
TOTALYTD([Ventas Reales], Calendario[Date])

--- Ventas reales
Ventas Reales = 
SUMX(
    'Order Details',
    'Order Details'[Quantity] * 'Order Details'[UnitPrice] * (1-'Order Details'[Discount])
)

--- Crecimiento vs año anterior
Crecimiento VS anio Anterior = 
DIVIDE([Ventas Reales] - CALCULATE([Ventas Reales], SAMEPERIODLASTYEAR(Calendario[Date])), CALCULATE([Ventas Reales], SAMEPERIODLASTYEAR(Calendario[Date])))
