
--- Punto # 1:
SELECT * FROM ProductosVenta WHERE Stock < 50;

SELECT COUNT(*) AS Cant_Empleado_Ult_2_Anios
FROM Empleados 
WHERE FechaContratacion >= DATEADD(YYYY, -2, GETDATE());


-- Punto # 2:
SELECT CP.NombreCategoria, SUM(PV.TotalPedido) AS TOTAL_X_CATEGORIA
FROM PedidosVenta PV JOIN DetallePedido DP
ON PV.PedidoVentaID = DP.PedidoVentaID
JOIN ProductosVenta PVS
ON PVS.ProductoVentaID = DP.ProductoVentaID
JOIN CategoriasProducto CP
ON CP.CategoriaID = PVS.CategoriaID
GROUP BY CP.NombreCategoria
ORDER BY TOTAL_X_CATEGORIA DESC

/* 5 clientes mayor cantidad de pedidos*/
SELECT TOP 5 CV.Nombre, CV.Apellido, COUNT(*) AS Cant_Pedidos
FROM PedidosVenta PV JOIN ClientesVenta CV
ON PV.ClienteID = CV.ClienteID
GROUP BY cv.Nombre, CV.Apellido
ORDER BY Cant_Pedidos DESC

--- Punto # 3:
SELECT CONCAT(E.Nombre, ' ', E.Apellido) AS Nombre_Empleado, p.NombreProyecto
FROM EmpleadoProyecto EP JOIN Empleados E
ON EP.EmpleadoID = E.EmpleadoID
JOIN Proyectos P
ON EP.ProyectoID = P.ProyectoID;

-- lista empleados sin proyectos
SELECT CONCAT(E.Nombre, ' ', E.Apellido) AS Nombre_Empleado
FROM EmpleadoProyecto EP RIGHT JOIN Empleados E
ON EP.EmpleadoID = E.EmpleadoID
WHERE EP.ProyectoID IS NULL;

--- Punto # 4:
SELECT D.NombreDepartamento,  AVG(E.Salario) AS Salario_Promedio
FROM Empleados E JOIN Departamentos D 
ON E.DepartamentoID = d.DepartamentoID
GROUP BY D.NombreDepartamento;

-- Identificar 3 empleados con el salario mas alto
SELECT TOP 3 CONCAT(Nombre, ' ', Apellido) AS Nombre_Empleado, Salario
FROM Empleados
ORDER BY Salario DESC
