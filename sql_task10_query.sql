CREATE TABLE inventory_stat(
    total_qty INT
);


CREATE OR REPLACE FUNCTION update_total_qty()
RETURNS TRIGGER
AS
$$
DECLARE
   p_row_count INT;
BEGIN
   SELECT COUNT(*) FROM inventory_stat
   INTO p_row_count;
   
   IF p_row_count > 0 THEN
      UPDATE inventory_stat 
      SET total_qty = total_qty + NEW.quantity;
   ELSE
      INSERT INTO inventory_stat(total_qty)
      VALUES(new.quantity);
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE PLPGSQL

CREATE TRIGGER inventory_before_insert
BEFORE INSERT
ON sales
FOR EACH ROW
EXECUTE FUNCTION update_total_qty();

INSERT INTO sales
VALUES(1,'cd-52455','2099-12-31','2099-12-31','sec cls','cg-45','FUR-BO-10001798',9999, 100,100)
RETURNING *;



INSERT INTO sales
VALUES(1,'cd-52455','2099-12-31','2099-12-31','second cls','cg-55','OFF-ST-10000760',991099, 10100,9000,1000)
RETURNING *;	

select * from sales

select * from inventory_stat

select * from sales where product_id = 'OFF-ST-10000760'









