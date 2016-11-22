# DRYDataKit


A lightweight and convenient Core Data wrapper written in Swift


## usage

### default initializer

just call 

```
	DRYManagedObjectContext.defaultContext()
```


### CRUD

#### create

if your NSManagedObject inherit from DRYManageObject

```swift

let p = Person()

```

else:

```swift

let p = Person.create()

```

#### query

query a person with age 20

```swift
	let p:Person? = Person.find(attribute:"age", with:20)

```

query all

```swift
	let p:Person? = Person.find(attribute:"age", with:20)
```

#### update

set attribute and save

```swift
	p.age = 21
	p.save()

```

#### delete

delete object

```swift
	p.delete()

```

### multi thread

if you want to use in other thread, you must use child context or concurrent 


```swift
	let context = DRYManagedObjectContext.createChildContext()
	
```

or 

```swift
	let context = DRYManagedObjectContext.createConcurrentContext()
```

then

```swift
	let p = Person.create(Context:context)
```

or 

```
	let p:Person? = Person.find(attribute:"age", with:20, in:context)
```



