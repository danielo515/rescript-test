open Belt
open Test

let equal = (~message=?, a, b) => assertion(~message?, ~operator="equal", (a, b) => a === b, a, b)

let deepEqual = (~message=?, a, b) =>
  assertion(~message?, ~operator="deepEqual", (a, b) => a == b, a, b)

let equalAsString = (~message=?, a, b) =>
  assertion(~message?, ~operator="equal", (a, b) => a->Int.toString === b, a, b)

testAsync("Async", cb => {
  let _ = Js.Global.setTimeout(() => {
    equal(1, 1)
    equalAsString(1, "1")
    cb()
  }, 100)
})

testAsync("Async", ~timeout=10, _cb => ())

test("Equals", () => {
  let a = 1
  let b = 1

  equal(a, b)
})

test("Should fail", () => {
  fail()
})

test("Should not throw", () => {
  doesNotThrow(() => ())
})

type user = {username: string, id: string}
test("DeepEquals", () => {
  let a = {username: "user", id: "a"}
  let b = {username: "user", id: "a"}
  equal(a.username, b.username)
  equal(a.username, b.id)
  equal(None, None)
  deepEqual(a, b)
  todo("Check that user is ok")
})

testAsync("Async with planned under", cb => {
  let _ = Js.Global.setTimeout(() => {
    equal(1, 1)
    equalAsString(1, "1")
    cb(~planned=0, ())
  }, 100)
})

testAsync("Async with planned exact", cb => {
  let _ = Js.Global.setTimeout(() => {
    equal(1, 1)
    equalAsString(1, "1")
    cb(~planned=2, ())
  }, 100)
})

testAsync("Async with planned over", cb => {
  let _ = Js.Global.setTimeout(() => {
    equal(1, 1)
    equalAsString(1, "1")
    cb(~planned=3, ())
  }, 100)
})

testAsync("Async with planned and fails", cb => {
  let _ = Js.Global.setTimeout(() => {
    equal(1, 2)
    equalAsString(1, "1")
    cb(~planned=2, ())
  }, 100)
})
