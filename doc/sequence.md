# Sequence

## 12c Release 1

### Sequence Pseudocolumns

A **sequence** is a schema object that can generate unique sequential values.
These values are often used for primary and unique keys.
You can refer to sequence values in SQL statements with these pseudocolumns:
- **CURRVAL**: Returns the current value of a sequence
- **NEXTVAL**: Increments the sequence and returns the next value

### How to Use Sequence Values

When you create a sequence, you can define its initial value and the increment between its values.
The first reference to **NEXTVAL** returns the initial value of the sequence.
Subsequent references to **NEXTVAL** increment the sequence value by the defined increment and return the new value.
Any reference to **CURRVAL** always returns the current value of the sequence, which is the value returned by the last reference to **NEXTVAL**.

### Frequently Used SQL

```
create sequence sample_seq nocycle nocache;

drop sequence sample_seq;


```
