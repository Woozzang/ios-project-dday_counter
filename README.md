# DdayCounter

<img src = "/Resources/main_1.png">
<br />

<img src = "/Resources/main_2.png">
<br />

## 사용 요소 및 개념

`UITabBarController`, `UICollectionView` , `DateFormatter`, `NotificationCenter`, `UTC(TimeZone)`
<br />

## 달성

✅  CollectionViewCell 커스텀 (크기, 레이아웃)

✅  UIDatePicker 사용

✅  DateFormatter 와 UTC 개념 익히기

✅  DdayDataManager 구현

✅  Dday 모델 타입 구현

✅  동적 버전 분기 사용 ( if #avaliable( ) )

✅  폴더링
<br />

## 달성 예정

- [ ]  Dday 모델 리스트 Persistent 저장 ( Realm 사용법을 배우고 적용한다 )
- [ ]  등록한 D-day 의 삭제 ( 컬렉션 뷰 아이템에 삭제 버튼을 넣고 관련 기능을 구현한다 )
- [ ]  D-day 컬렉션뷰 아이템들의 위치 변경
<br /><br />

# 해결 과정 🏃🏻🏃🏻‍♀️
## 컬렉션 뷰 셀 크기 설정
<br />

### 공통

- 사이즈관련 속성은 다 CGFloat 이다. 연산의 결과 역시 소수점으로 나온다.
    - ❗️ 제에에에발 rounded(.down) 으로 소수점 날려버리자.
    - 이것 때문에 시간 오래 썼다. 3개 나올 셀 너비를 계산 했는데 2개만 나왔음... 소수점 계산 때문에 전체 너비가 부족해서
    - 이것 때문에 약간의 오차는 생길 수 있따.
- 프로토타입 셀 크기 → 이것은 실제 셀크기에 전혀~ 반영되지 않는다.
- 셀 크기는 DelegateFlowLayout 메서드에서 반환해주자
    - 만약 커스텀 플로우 레이아웃을 사용한다면 그건 아직 모르겠다...
<br />

### 너비 계산

- sectionInset - left, right 고려
- layout.minimumInterItemSpacing 고려
    - 이 때 기본 layout 을 사용한다면 UICollectionViewFlowLayout 으로 캐스팅해야한다.
    - InterItemSpacing 과 lineSpacing 은 스크롤 축방향에 따라 달라지니 유념하자. 세로축의 경우 열간이 InterItemSpacing 임.
<br />

### 높이 계산

- frame 과safeAreaInset 을 이용하여 주어진 화면 크기를 얻고, 원하는 셀 높이를 적절히 계산

```swift
// 행에서 2개 열에서 4개 정도 보이게 레이아웃한 크기

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    
    guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize.zero }

    var size = CGSize()

    var givenHeight = (collectionView.bounds.height - (collectionView.safeAreaInsets.top) - (layout.minimumLineSpacing * 4)) / 4
    
    var givenWidth = collectionView.bounds.width - (layout.sectionInset.left + layout.sectionInset.right)
    
    givenWidth = (givenWidth - (layout.minimumInteritemSpacing) * 1) / 2
    
    size.height = givenHeight.rounded(.down)
    size.width = givenWidth.rounded(.down)

    return size
  }
```
<br /><br />

# Timezone ⏰

```swift
anchorDate	Foundation.Date	2021-10-21 08:51:00 UTC
```

`UIDatePicker.date`는 UTC+0:00 을 기준으로 시간을 반환해 주었다.

→ 실제로 나는 오후 5시인데 date 속성 반환 값은 9시간 전인 오전 8시

→ 왜냐면 서울은 UTC+9:00 시간대이기 때문

→ DateFormatter.date(from:) 도 UTC+0:00 기준으로 반환해줌.....

그럼 UTC 가 무엇이냐? 하면 협정 세계시 인데, 기준으로 GMT 를 사용하는 것이 특징이다.

→ GMT 란 그리니치 천문대의 시간대를 기준 시간 0시 0분으로 보는 것

그래서 일상에서 UTC 와 GMT 를 혼용해서 쓰지만, 실제로 약간~의 차이는 있기 때문에 기술분야에서는 UTC 를 사용한다.
<br /><br />

### 그래서 나는 어떻게 UTC+9 가 적용된 date 를 얻을 수 있는가

TimeFormatter 를 사용한다. 이 객체의 속성 timezone 은 디폴트로 시스템 타임존을 사용한다.

즉 기기가 위치한 지역의 타임존으로 자동으로 변환해준다.

직접 시스템 타임존을 접근하는 방법은 TimeZone.current 를 사용한다.

→ 기기(시스템)이 현재 사용하고 있는 타임존을 알 수있다.
<br /><br />

## 겪은 컴파일 오류

`'-[UICollectionViewController loadView] loaded the "BYZ-38-t0r-view-8bC-Xf-vdC" nib but didn't get a UICollectionView.'`

→ `BYZ-38-t0r-view-8bC-Xf-vdC` 이거 닙네임 이잖아?? view 앞은 뷰컨의 id, view 뒤는 컨텐트뷰의 id

→ 스토리보드 파일을 소스코드로 보기해서 찾아보면 어떤 뷰컨에서 문제가 생기는지 알 수 있다.

→ 스토리 보드 뷰컨에 잘못된 커스텀 클래스를 연결했었다.
<br />

### **loadView()**

Creates the view that the controller manages.

→ 위 오류 메시지보면 컬렉션 뷰컨이 이걸 호출한다. 콘텐트 뷰를 만드는 메서드이다.

→ 컨텐트 뷰를 커스텀하려면 이 메서드를 오버라이딩 해주면 된다.
<br />

### TabBarItem 이미지 적용이 안된다.

인터페이스 빌더에서 넣어주었는데, 크기가 누를때 줄어들거나 아예 보이지 않는다.

그냥 init 에서 새로 넣어주었다.

```swift
required init?(coder: NSCoder) {
    
    super.init(coder: coder)
    
    tabBarItem = UITabBarItem(title: "New", image: UIImage(systemName: "plus"), tag: 1)
  }
```
